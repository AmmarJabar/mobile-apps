import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:coffee_brew_tracker/core/database/database_provider.dart';
import 'package:coffee_brew_tracker/features/brew_log/domain/entities/brew_entity.dart';
import 'package:coffee_brew_tracker/features/brew_log/data/repositories/brew_repository_impl.dart';
import 'package:coffee_brew_tracker/features/brew_log/data/datasources/brew_local_datasource.dart';
import 'package:coffee_brew_tracker/core/database/app_database.dart';

class HistoryState {
  final List<BrewEntity> brews;
  final bool isLoading;
  final String? error;

  HistoryState({this.brews = const [], this.isLoading = false, this.error});

  HistoryState copyWith({List<BrewEntity>? brews, bool? isLoading, String? error}) {
    return HistoryState(
      brews: brews ?? this.brews,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class HistoryController extends StateNotifier<HistoryState> {
  final BrewRepositoryImpl _repository;
  final AppDatabase _db;

  HistoryController(this._repository, this._db) : super(HistoryState()) {
    loadBrews();
  }

  Future<void> loadBrews({
    String? brewType, 
    int? minRating,
    String? origin,
    String? process,
    String? roastLevel,
  }) async {
    state = state.copyWith(isLoading: true);
    try {
      final brewsDb = await _db.getBrewsFiltered(
        brewType: brewType, 
        minRating: minRating,
        origin: origin,
        process: process,
        roastLevel: roastLevel,
      );
      
      final brews = brewsDb.map((b) => BrewEntity(
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
      )).toList();

      state = state.copyWith(brews: brews, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> deleteBrew(int id) async {
    await _db.deleteBrew(id);
    await loadBrews(); // Reload current view
  }

  Future<void> clearAllBrews() async {
    await _db.clearAllData();
    await loadBrews();
  }

  Future<List<String>> getDistinctOrigins() {
    return _db.getDistinctOrigins();
  }

  Future<List<String>> getDistinctCoffeeNames() {
    return _db.getDistinctCoffeeNames();
  }

  Future<List<String>> getDistinctRoasters() {
    return _db.getDistinctRoasters();
  }
}

final historyControllerProvider = StateNotifierProvider<HistoryController, HistoryState>((ref) {
  final db = ref.watch(databaseProvider);
  final repo = BrewRepositoryImpl(BrewLocalDataSource(db));
  return HistoryController(repo, db);
});
