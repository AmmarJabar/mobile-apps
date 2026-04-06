import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:coffee_brew_tracker/core/database/tables/brew_tables.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Brews, PourOvers, Espressos])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await m.addColumn(brews, brews.roaster);
          }
        },
      );

  // ── Brew CRUD ─────────────────────────────────────────────────────────────

  Stream<List<Brew>> watchAllBrews() {
    return (select(brews)
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .watch();
  }

  Future<List<Brew>> getAllBrews() {
    return (select(brews)
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
  }

  Future<List<Brew>> getRecentBrews({int limit = 5}) {
    return (select(brews)
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
          ..limit(limit))
        .get();
  }

  Future<int> insertBrew(BrewsCompanion brew) =>
      into(brews).insert(brew);

  Future<bool> updateBrew(BrewsCompanion brew) =>
      update(brews).replace(brew);

  Future<int> deleteBrew(int id) =>
      (delete(brews)..where((t) => t.id.equals(id))).go();

  Future<void> clearAllData() {
    return transaction(() async {
      await delete(pourOvers).go();
      await delete(espressos).go();
      await delete(brews).go();
    });
  }

  Future<List<String>> getDistinctOrigins() async {
    final query = selectOnly(brews, distinct: true)..addColumns([brews.origin]);
    final rows = await query.get();
    return rows.map((r) => r.read(brews.origin)).whereType<String>().toList();
  }

  Future<List<String>> getDistinctCoffeeNames() async {
    final query = selectOnly(brews, distinct: true)..addColumns([brews.coffeeName]);
    final rows = await query.get();
    return rows.map((r) => r.read(brews.coffeeName)).whereType<String>().toList();
  }

  Future<List<String>> getDistinctRoasters() async {
    final query = selectOnly(brews, distinct: true)..addColumns([brews.roaster]);
    final rows = await query.get();
    return rows.map((r) => r.read(brews.roaster)).whereType<String>().toList();
  }

  Future<List<Brew>> getBrewsFiltered({
    String? brewType,
    int? minRating,
    DateTime? startDate,
    DateTime? endDate,
    String? origin,
    String? process,
    String? roastLevel,
  }) {
    final query = select(brews)
      ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]);
    if (brewType != null || minRating != null || startDate != null || endDate != null || origin != null || process != null || roastLevel != null) {
      query.where((t) {
        Expression<bool> cond = const Constant(true);
        if (brewType != null) cond = cond & t.brewType.equals(brewType);
        if (minRating != null) cond = cond & t.rating.isBiggerOrEqualValue(minRating);
        if (startDate != null) cond = cond & t.createdAt.isBiggerOrEqualValue(startDate);
        if (endDate != null) cond = cond & t.createdAt.isSmallerOrEqualValue(endDate);
        if (origin != null) cond = cond & t.origin.equals(origin);
        if (process != null) cond = cond & t.process.equals(process);
        if (roastLevel != null) cond = cond & t.roastLevel.equals(roastLevel);
        return cond;
      });
    }
    return query.get();
  }

  // ── PourOver CRUD ─────────────────────────────────────────────────────────

  Future<PourOver?> getPourOverForBrew(int brewId) =>
      (select(pourOvers)..where((t) => t.brewId.equals(brewId)))
          .getSingleOrNull();

  Future<int> insertPourOver(PourOversCompanion po) =>
      into(pourOvers).insert(po);

  // ── Espresso CRUD ─────────────────────────────────────────────────────────

  Future<Espresso?> getEspressoForBrew(int brewId) =>
      (select(espressos)..where((t) => t.brewId.equals(brewId)))
          .getSingleOrNull();

  Future<int> insertEspresso(EspressosCompanion esp) =>
      into(espressos).insert(esp);

  // ── Aggregates for insights ───────────────────────────────────────────────

  Future<int> getTotalBrewCount() async {
    final count = countAll();
    final q = selectOnly(brews)..addColumns([count]);
    final row = await q.getSingle();
    return row.read(count) ?? 0;
  }

  Future<double?> getAverageRating() async {
    final avg = brews.rating.avg();
    final q = selectOnly(brews)..addColumns([avg]);
    final row = await q.getSingle();
    return row.read(avg);
  }

  Future<int> getBrewsThisWeekCount() async {
    final weekAgo = DateTime.now().subtract(const Duration(days: 7));
    final count = countAll(
      filter: brews.createdAt.isBiggerOrEqualValue(weekAgo),
    );
    final q = selectOnly(brews)..addColumns([count]);
    final row = await q.getSingle();
    return row.read(count) ?? 0;
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'brewlog.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
