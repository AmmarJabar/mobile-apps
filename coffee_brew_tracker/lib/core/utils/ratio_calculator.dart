import 'package:coffee_brew_tracker/core/constants/app_constants.dart';

class RatioCalculator {
  RatioCalculator._();

  static double pourOver(double coffeeWeight, double waterWeight) {
    if (coffeeWeight <= 0) return 0;
    return waterWeight / coffeeWeight;
  }

  static double espresso(double dose, double brewYield) {
    if (dose <= 0) return 0;
    return brewYield / dose;
  }

  static bool isPourOverIdeal(double ratio) {
    return ratio >= AppConstants.idealPourOverRatioMin &&
        ratio <= AppConstants.idealPourOverRatioMax;
  }

  static bool isEspressoIdeal(double ratio) {
    return ratio >= AppConstants.idealEspressoRatioMin &&
        ratio <= AppConstants.idealEspressoRatioMax;
  }
}
