import 'package:flutter_test/flutter_test.dart';
import 'package:tm_solo_calculator/app/models/calculators/modifier.dart';

void main() {
  group('Modifier', () {
    test('Should be created with default values', () {
      final modifier = CalculatorModifier();

      expect(modifier.shouldSkipQuantity(), isFalse);
      expect(modifier.shouldSkipProduction(), isFalse);
    });

    test('Should be created with given values', () {
      final modifier = CalculatorModifier(shouldSkipProduction: () => true);

      expect(modifier.shouldSkipQuantity(), isFalse);
      expect(modifier.shouldSkipProduction(), isTrue);
    });
  });
}
