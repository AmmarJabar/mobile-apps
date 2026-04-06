class AppConstants {
  AppConstants._();

  static const double minGrindSize = 0.0;
  static const double maxGrindSize = 50.0;
  static const double minTemperature = 60.0;
  static const double maxTemperature = 100.0;

  static const double idealPourOverRatioMin = 15.0;
  static const double idealPourOverRatioMax = 17.0;
  static const double idealEspressoRatioMin = 1.5;
  static const double idealEspressoRatioMax = 2.5;

  static const List<String> pourOverMethods = [
    'V60',
    'Kalita Wave',
    'Chemex',
    'Clever Dripper',
    'Origami',
    'Other',
  ];

  static const List<String> roastLevels = [
    'Light',
    'Light-Medium',
    'Medium',
    'Medium-Dark',
    'Dark',
  ];

  static const List<String> processes = [
    'Washed',
    'Natural',
    'Honey',
    'Anaerobic',
    'Extended Fermented',
    'Other',
  ];

  static const String pourOver = 'pour_over';
  static const String espresso = 'espresso';
}
