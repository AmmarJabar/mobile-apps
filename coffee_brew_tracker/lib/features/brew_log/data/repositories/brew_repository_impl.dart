import 'package:drift/drift.dart';
import 'package:coffee_brew_tracker/core/database/app_database.dart';
import 'package:coffee_brew_tracker/features/brew_log/data/datasources/brew_local_datasource.dart';
import 'package:coffee_brew_tracker/features/brew_log/domain/entities/brew_entity.dart';
import 'package:coffee_brew_tracker/features/brew_log/domain/repositories/brew_repository.dart';

class BrewRepositoryImpl implements BrewRepository {
  final BrewLocalDataSource _localDataSource;

  BrewRepositoryImpl(this._localDataSource);

  @override
  Future<void> savePourOverBrew(BrewEntity brew) async {
    final brewId = await _localDataSource.insertBrew(
      BrewsCompanion.insert(
        brewType: brew.brewType,
        coffeeName: brew.coffeeName,
        origin: Value(brew.origin),
        process: Value(brew.process),
        roastLevel: Value(brew.roastLevel),
        grindSize: brew.grindSize,
        temperature: brew.temperature,
        coffeeWeight: brew.coffeeWeight,
        waterWeight: Value(brew.waterWeight),
        brewTime: brew.brewTime,
        ratio: brew.ratio,
        rating: brew.rating,
        notes: Value(brew.notes),
        flavorNotes: Value(brew.flavorNotes),
      ),
    );

    await _localDataSource.insertPourOver(
      PourOversCompanion.insert(
        brewId: brewId,
        brewMethod: brew.brewMethod ?? 'Unknown',
        recipe: Value(brew.recipe),
      ),
    );
  }

  @override
  Future<void> saveEspressoBrew(BrewEntity brew) async {
    final brewId = await _localDataSource.insertBrew(
      BrewsCompanion.insert(
        brewType: brew.brewType,
        coffeeName: brew.coffeeName,
        origin: Value(brew.origin),
        process: Value(brew.process),
        roastLevel: Value(brew.roastLevel),
        grindSize: brew.grindSize,
        temperature: brew.temperature,
        coffeeWeight: brew.dose ?? brew.coffeeWeight, // Use dose as coffee weight for espresso
        brewTime: brew.extractionTime ?? brew.brewTime, // Use extraction time as brew time
        ratio: brew.ratio,
        rating: brew.rating,
        notes: Value(brew.notes),
        flavorNotes: Value(brew.flavorNotes),
      ),
    );

    await _localDataSource.insertEspresso(
      EspressosCompanion.insert(
        brewId: brewId,
        dose: brew.dose ?? 0.0,
        brewYield: brew.brewYield ?? 0.0,
        extractionTime: brew.extractionTime ?? 0,
        machineUsed: Value(brew.machineUsed),
        pressure: Value(brew.pressure),
        preInfusionTime: Value(brew.preInfusionTime),
      ),
    );
  }

  @override
  Future<List<BrewEntity>> getAllBrews() async {
    final brewsDb = await _localDataSource.getAllBrews();
    return brewsDb.map((b) => _mapBrewToEntity(b)).toList();
  }

  @override
  Future<List<BrewEntity>> getRecentBrews({int limit = 5}) async {
    final brewsDb = await _localDataSource.getRecentBrews(limit: limit);
    return brewsDb.map((b) => _mapBrewToEntity(b)).toList();
  }

  BrewEntity _mapBrewToEntity(Brew b) {
    return BrewEntity(
      id: b.id,
      brewType: b.brewType,
      coffeeName: b.coffeeName,
      origin: b.origin,
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
    );
  }
}
