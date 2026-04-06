import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:coffee_brew_tracker/core/database/database_provider.dart';
import 'package:coffee_brew_tracker/features/brew_log/domain/entities/brew_entity.dart';

import 'package:coffee_brew_tracker/core/database/app_database.dart';

class InsightsState {
  final List<BrewEntity> brews;         // filtered brews (for charts)
  final List<BrewEntity> allBrews;      // unfiltered brews (for stats)
  final bool isLoading;

  // Filter options (distinct values from DB)
  final List<String> availableCoffeeNames;
  final List<String> availableOrigins;
  final List<String> availableProcesses;
  final List<String> availableRoastLevels;

  // Active filters
  final String? filterCoffeeName;
  final String? filterOrigin;
  final String? filterProcess;
  final String? filterRoastLevel;
  final String? filterBrewType; // 'pour_over' | 'espresso'

  InsightsState({
    this.brews = const [],
    this.allBrews = const [],
    this.isLoading = false,
    this.availableCoffeeNames = const [],
    this.availableOrigins = const [],
    this.availableProcesses = const [],
    this.availableRoastLevels = const [],
    this.filterCoffeeName,
    this.filterOrigin,
    this.filterProcess,
    this.filterRoastLevel,
    this.filterBrewType,
  });

  InsightsState copyWith({
    List<BrewEntity>? brews,
    List<BrewEntity>? allBrews,
    bool? isLoading,
    List<String>? availableCoffeeNames,
    List<String>? availableOrigins,
    List<String>? availableProcesses,
    List<String>? availableRoastLevels,
    Object? filterCoffeeName = _sentinel,
    Object? filterOrigin = _sentinel,
    Object? filterProcess = _sentinel,
    Object? filterRoastLevel = _sentinel,
    Object? filterBrewType = _sentinel,
  }) {
    return InsightsState(
      brews: brews ?? this.brews,
      allBrews: allBrews ?? this.allBrews,
      isLoading: isLoading ?? this.isLoading,
      availableCoffeeNames: availableCoffeeNames ?? this.availableCoffeeNames,
      availableOrigins: availableOrigins ?? this.availableOrigins,
      availableProcesses: availableProcesses ?? this.availableProcesses,
      availableRoastLevels: availableRoastLevels ?? this.availableRoastLevels,
      filterCoffeeName: filterCoffeeName == _sentinel
          ? this.filterCoffeeName
          : filterCoffeeName as String?,
      filterOrigin: filterOrigin == _sentinel
          ? this.filterOrigin
          : filterOrigin as String?,
      filterProcess: filterProcess == _sentinel
          ? this.filterProcess
          : filterProcess as String?,
      filterRoastLevel: filterRoastLevel == _sentinel
          ? this.filterRoastLevel
          : filterRoastLevel as String?,
      filterBrewType: filterBrewType == _sentinel
          ? this.filterBrewType
          : filterBrewType as String?,
    );
  }

  // ── Computed stats from filtered brews ───────────────────────────────────
  int get totalBrews => allBrews.length;
  int get filteredCount => brews.length;

  double get averageRating {
    if (brews.isEmpty) return 0.0;
    return brews.map((b) => b.rating).reduce((a, b) => a + b) / brews.length;
  }

  int get brewsThisWeek {
    final weekAgo = DateTime.now().subtract(const Duration(days: 7));
    return allBrews
        .where((b) => b.createdAt != null && b.createdAt!.isAfter(weekAgo))
        .length;
  }

  double get bestRating =>
      brews.isEmpty ? 0.0 : brews.map((b) => b.rating).reduce((a, b) => a > b ? a : b).toDouble();

  // Brew type distribution
  Map<String, int> get brewTypeDistribution {
    final map = <String, int>{};
    for (final b in brews) {
      map[b.brewType] = (map[b.brewType] ?? 0) + 1;
    }
    return map;
  }

  // Top rated coffees (avg rating per coffeeName)
  List<MapEntry<String, double>> get topRatedCoffees {
    final map = <String, List<int>>{};
    for (final b in brews) {
      map.putIfAbsent(b.coffeeName, () => []).add(b.rating);
    }
    final entries = map.entries
        .map((e) => MapEntry(
            e.key, e.value.reduce((a, b) => a + b) / e.value.length))
        .toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return entries.take(5).toList();
  }

  bool get hasActiveFilters =>
      filterCoffeeName != null ||
      filterOrigin != null ||
      filterProcess != null ||
      filterRoastLevel != null ||
      filterBrewType != null;
}

// Sentinel object to distinguish "not passed" from null
const _sentinel = Object();

// ── Controller ───────────────────────────────────────────────────────────────

class InsightsController extends StateNotifier<InsightsState> {
  final AppDatabase _db;

  InsightsController(this._db) : super(InsightsState()) {
    loadInsights();
  }

  Future<void> loadInsights() async {
    state = state.copyWith(isLoading: true);

    // Load all brews for global stats
    final allBrewsDb = await _db.getAllBrews();
    final allBrews = _mapBrews(allBrewsDb);

    // Load distinct filter options
    final coffeeNames = await _db.getDistinctCoffeeNames();
    final origins = await _db.getDistinctOrigins();
    final processes = _getDistinctProcesses(allBrews);
    final roastLevels = _getDistinctRoastLevels(allBrews);

    // Load filtered brews
    final filteredBrewsDb = await _db.getBrewsFiltered(
      brewType: state.filterBrewType,
      origin: state.filterOrigin,
      process: state.filterProcess,
      roastLevel: state.filterRoastLevel,
    );
    var filteredBrews = _mapBrews(filteredBrewsDb);

    // Apply coffee name filter (not supported by DB method directly)
    if (state.filterCoffeeName != null) {
      filteredBrews = filteredBrews
          .where((b) => b.coffeeName == state.filterCoffeeName)
          .toList();
    }

    state = state.copyWith(
      brews: filteredBrews,
      allBrews: allBrews,
      isLoading: false,
      availableCoffeeNames: coffeeNames,
      availableOrigins: origins,
      availableProcesses: processes,
      availableRoastLevels: roastLevels,
    );
  }

  Future<void> setFilter({
    Object? coffeeName = _sentinel,
    Object? origin = _sentinel,
    Object? process = _sentinel,
    Object? roastLevel = _sentinel,
    Object? brewType = _sentinel,
  }) async {
    state = state.copyWith(
      filterCoffeeName: coffeeName,
      filterOrigin: origin,
      filterProcess: process,
      filterRoastLevel: roastLevel,
      filterBrewType: brewType,
    );
    await loadInsights();
  }

  Future<void> clearAllFilters() async {
    state = InsightsState(
      availableCoffeeNames: state.availableCoffeeNames,
      availableOrigins: state.availableOrigins,
      availableProcesses: state.availableProcesses,
      availableRoastLevels: state.availableRoastLevels,
    );
    await loadInsights();
  }

  List<BrewEntity> _mapBrews(List<Brew> brewsDb) {
    return brewsDb
        .map((b) => BrewEntity(
              id: b.id,
              brewType: b.brewType,
              coffeeName: b.coffeeName,
              origin: b.origin,
              roaster: b.roaster,
              process: b.process,
              roastLevel: b.roastLevel,
              grindSize: b.grindSize,
              temperature: b.temperature,
              coffeeWeight: b.coffeeWeight,
              waterWeight: b.waterWeight,
              brewTime: b.brewTime,
              ratio: b.ratio,
              rating: b.rating,
              notes: b.notes,
              flavorNotes: b.flavorNotes,
              createdAt: b.createdAt,
            ))
        .toList();
  }

  List<String> _getDistinctProcesses(List<BrewEntity> brews) {
    final result = brews
        .map((b) => b.process)
        .whereType<String>()
        .toSet()
        .toList();
    result.sort();
    return result;
  }

  List<String> _getDistinctRoastLevels(List<BrewEntity> brews) {
    final result = brews
        .map((b) => b.roastLevel)
        .whereType<String>()
        .toSet()
        .toList();
    result.sort();
    return result;
  }
}

final insightsControllerProvider =
    StateNotifierProvider<InsightsController, InsightsState>((ref) {
  final db = ref.watch(databaseProvider);
  return InsightsController(db);
});
