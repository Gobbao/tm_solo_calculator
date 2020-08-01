import 'package:flutter_test/flutter_test.dart';
import 'package:tm_solo_calculator/app/models/calculators/calculator.dart';

class CalculatorMatcher extends CustomMatcher {
  CalculatorMatcher(Matcher matcher)
    : super('Calculator that is', 'object', matcher);

  @override
  Object featureValueOf(actual) {
    final actualAs = (actual as Calculator);

    return {
      'resource': actualAs.resource.capitalizedName,
      'targetName': actualAs.targetName,
      'conversionCost': actualAs.conversionCost,
      'missingQuantity': actualAs.missingQuantity,
      'missingProduction': actualAs.missingProduction,
    };
  }
}
