import 'package:flutter_test/flutter_test.dart';
import 'package:tm_solo_calculator/app/models/parameters/parameter.dart';
import 'package:tm_solo_calculator/app/models/resources/energy.dart';
import 'package:tm_solo_calculator/app/models/resources/resource.dart';
import 'package:tm_solo_calculator/app/state/converter.dart';

import '../../matchers/calculator.dart';

void main() {
  group('Converter State', () {
    ConverterState state;
    final defaultCalculators = [
      CalculatorMatcher(equals({
        'resource': equals('Mega credit'),
        'targetName': equals('Ocean'),
        'conversionCost': equals(18),
        'missingQuantity': equals(162),
        'missingProduction': equals(13),
      })),
      CalculatorMatcher(equals({
        'resource': equals('Mega credit'),
        'targetName': equals('Oxygen'),
        'conversionCost': equals(23),
        'missingQuantity': equals(322),
        'missingProduction': equals(25),
      })),
      CalculatorMatcher(equals({
        'resource': equals('Mega credit'),
        'targetName': equals('Temperature'),
        'conversionCost': equals(14),
        'missingQuantity': equals(266),
        'missingProduction': equals(21),
      })),
      CalculatorMatcher(equals({
        'resource': equals('Plant'),
        'targetName': equals('Oxygen'),
        'conversionCost': equals(8),
        'missingQuantity': equals(112),
        'missingProduction': equals(9),
      })),
      CalculatorMatcher(equals({
        'resource': equals('Heat'),
        'targetName': equals('Temperature'),
        'conversionCost': equals(8),
        'missingQuantity': equals(152),
        'missingProduction': equals(12),
      })),
      CalculatorMatcher(equals({
        'resource': equals('Energy'),
        'targetName': equals('Temperature'),
        'conversionCost': equals(8),
        'missingQuantity': equals(152),
        'missingProduction': equals(12),
      })),
    ];

    setUp(() {
      state = ConverterState();
    });

    test('Should be initialized with default data', () {
      final calculators = state.generateCalculators();

      expect(calculators, hasLength(6));
      expect(calculators, containsAll(defaultCalculators));
    });

    test('Should add resource converter', () {
      final resource = Resource(capitalizedName: 'Resource Foo', icon: null);
      final expectedCalculators = defaultCalculators.followedBy([
        CalculatorMatcher(equals({
          'resource': equals(resource.capitalizedName),
          'targetName': equals('Temperature'),
          'conversionCost': equals(3),
          'missingQuantity': equals(51),
          'missingProduction': equals(4),
        })),
      ]);

      state.addResourceConverter(resource, energy, 3);

      final calculators = state.generateCalculators();

      expect(calculators, hasLength(7));
      expect(calculators, containsAll(expectedCalculators));
    });

    test('Should add parameter converter', () {
      final resource = Resource(capitalizedName: 'Resource Foo', icon: null);
      final parameter = Parameter(
        capitalizedName: 'Parameter Bar',
        initialLevel: 0,
        totalLevels: 15,
        levelMultiplier: 2,
      );
      final expectedCalculators = defaultCalculators.followedBy([
        CalculatorMatcher(equals({
          'resource': equals(resource.capitalizedName),
          'targetName': equals(parameter.capitalizedName),
          'conversionCost': equals(15),
          'missingQuantity': equals(225),
          'missingProduction': equals(18),
        })),
      ]);

      state.addParameterConverter(resource, parameter, 15);

      final calculators = state.generateCalculators();

      expect(calculators, hasLength(7));
      expect(calculators, containsAll(expectedCalculators));
    });
  });
}
