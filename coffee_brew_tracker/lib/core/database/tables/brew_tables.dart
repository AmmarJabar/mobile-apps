import 'package:drift/drift.dart';

// ── Brews (main shared table) ────────────────────────────────────────────────
class Brews extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get brewType => text()(); // 'pour_over' | 'espresso'
  TextColumn get coffeeName => text()();
  TextColumn get origin => text().nullable()();
  TextColumn get roaster => text().nullable()();
  TextColumn get process => text().nullable()();
  TextColumn get roastLevel => text().nullable()();
  RealColumn get grindSize => real()();
  RealColumn get temperature => real()();
  RealColumn get coffeeWeight => real()();
  RealColumn get waterWeight => real().nullable()();
  IntColumn get brewTime => integer()(); // seconds
  RealColumn get ratio => real()(); // auto-calculated
  IntColumn get rating => integer()(); // 1–5
  TextColumn get notes => text().nullable()();
  TextColumn get flavorNotes => text().nullable()();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
}

// ── PourOvers ────────────────────────────────────────────────────────────────
class PourOvers extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get brewId => integer().references(Brews, #id)();
  TextColumn get brewMethod => text()(); // V60, Kalita, etc.
  TextColumn get recipe => text().nullable()();
}

// ── Espressos ────────────────────────────────────────────────────────────────
class Espressos extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get brewId => integer().references(Brews, #id)();
  RealColumn get dose => real()(); // coffee weight in
  RealColumn get brewYield => real()(); // liquid out ('yield' is reserved)
  IntColumn get extractionTime => integer()(); // seconds
  TextColumn get machineUsed => text().nullable()();
  RealColumn get pressure => real().nullable()(); // bar
  IntColumn get preInfusionTime => integer().nullable()(); // seconds
}
