import 'package:coffee_brew_tracker/features/brew_log/domain/entities/brew_entity.dart';

abstract class BrewRepository {
  Future<void> savePourOverBrew(BrewEntity brew);
  Future<void> saveEspressoBrew(BrewEntity brew);
  Future<List<BrewEntity>> getAllBrews();
  Future<List<BrewEntity>> getRecentBrews({int limit});
}
