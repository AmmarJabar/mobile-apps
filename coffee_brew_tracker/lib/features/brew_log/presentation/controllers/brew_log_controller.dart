import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:coffee_brew_tracker/core/database/database_provider.dart';
import 'package:coffee_brew_tracker/features/brew_log/data/datasources/brew_local_datasource.dart';
import 'package:coffee_brew_tracker/features/brew_log/data/repositories/brew_repository_impl.dart';
import 'package:coffee_brew_tracker/features/brew_log/domain/entities/brew_entity.dart';
import 'package:coffee_brew_tracker/features/brew_log/domain/repositories/brew_repository.dart';

final brewLocalDataSourceProvider = Provider<BrewLocalDataSource>((ref) {
  final db = ref.watch(databaseProvider);
  return BrewLocalDataSource(db);
});

final brewRepositoryProvider = Provider<BrewRepository>((ref) {
  final localDataSource = ref.watch(brewLocalDataSourceProvider);
  return BrewRepositoryImpl(localDataSource);
});

enum BrewLogState { initial, loading, success, error }

class BrewLogController extends StateNotifier<BrewLogState> {
  final BrewRepository _repository;

  BrewLogController(this._repository) : super(BrewLogState.initial);

  Future<void> savePourOver(BrewEntity brew) async {
    state = BrewLogState.loading;
    try {
      await _repository.savePourOverBrew(brew);
      state = BrewLogState.success;
    } catch (e) {
      state = BrewLogState.error;
    }
  }

  Future<void> saveEspresso(BrewEntity brew) async {
    state = BrewLogState.loading;
    try {
      await _repository.saveEspressoBrew(brew);
      state = BrewLogState.success;
    } catch (e) {
      state = BrewLogState.error;
    }
  }
}

final brewLogControllerProvider = StateNotifierProvider<BrewLogController, BrewLogState>((ref) {
  final repository = ref.watch(brewRepositoryProvider);
  return BrewLogController(repository);
});
