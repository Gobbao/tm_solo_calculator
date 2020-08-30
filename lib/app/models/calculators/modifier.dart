typedef Modifier = bool Function();

class CalculatorModifier {
  final Modifier shouldSkipQuantity;
  final Modifier shouldSkipProduction;

  CalculatorModifier({
    Modifier shouldSkipQuantity,
    Modifier shouldSkipProduction,
  })
    : shouldSkipQuantity = _applyDefaultIfAbsent(shouldSkipQuantity)
    , shouldSkipProduction = _applyDefaultIfAbsent(shouldSkipProduction);

  static Modifier _applyDefaultIfAbsent(Modifier modifier) {
    return modifier ?? _defaultModifier;
  }

  static bool _defaultModifier() => false;
}
