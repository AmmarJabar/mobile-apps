import 'package:coffee_brew_tracker/core/database/app_database.dart';

class BrewLocalDataSource {
  final AppDatabase _db;

  BrewLocalDataSource(this._db);

  Future<int> insertBrew(BrewsCompanion brew) async {
    return await _db.insertBrew(brew);
  }

  Future<void> insertPourOver(PourOversCompanion pourOver) async {
    await _db.insertPourOver(pourOver);
  }

  Future<void> insertEspresso(EspressosCompanion espresso) async {
    await _db.insertEspresso(espresso);
  }

  Future<List<Brew>> getAllBrews() async {
    return await _db.getAllBrews();
  }

  Future<List<Brew>> getRecentBrews({int limit = 5}) async {
    return await _db.getRecentBrews(limit: limit);
  }
}
