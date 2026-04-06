class BrewEntity {
  final int? id;
  final String brewType; // 'pour_over' | 'espresso'
  final String coffeeName;
  final String? origin;
  final String? roaster;
  final String? process;
  final String? roastLevel;
  final double grindSize;
  final double temperature;
  final double coffeeWeight;
  final double? waterWeight;
  final int brewTime; // seconds
  final double ratio;
  final int rating;
  final String? notes;
  final String? flavorNotes;
  final DateTime? createdAt;

  // Pour over specific
  final String? brewMethod;
  final String? recipe;

  // Espresso specific
  final double? dose;
  final double? brewYield;
  final int? extractionTime;
  final String? machineUsed;
  final double? pressure;
  final int? preInfusionTime;

  BrewEntity({
    this.id,
    required this.brewType,
    required this.coffeeName,
    this.origin,
    this.roaster,
    this.process,
    this.roastLevel,
    required this.grindSize,
    required this.temperature,
    required this.coffeeWeight,
    this.waterWeight,
    required this.brewTime,
    required this.ratio,
    required this.rating,
    this.notes,
    this.flavorNotes,
    this.createdAt,
    this.brewMethod,
    this.recipe,
    this.dose,
    this.brewYield,
    this.extractionTime,
    this.machineUsed,
    this.pressure,
    this.preInfusionTime,
  });
}
