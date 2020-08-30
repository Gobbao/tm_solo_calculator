import 'package:flutter_test/flutter_test.dart';
import 'package:tm_solo_calculator/app/models/calculators/calculator.dart';
import 'package:tm_solo_calculator/app/models/calculators/modifier.dart';
import 'package:tm_solo_calculator/app/models/converter.dart';
import 'package:tm_solo_calculator/app/models/graph/spanning_tree.dart';
import 'package:tm_solo_calculator/app/models/graph/spanning_tree_element.dart';
import 'package:tm_solo_calculator/app/models/parameters/generation.dart';
import 'package:tm_solo_calculator/app/models/parameters/parameter.dart';
import 'package:tm_solo_calculator/app/models/resources/resource.dart';

void main() {
  group('Calculator', () {
    final resourceA = Resource(capitalizedName: 'Resource A', icon: null);
    final resourceB = Resource(capitalizedName: 'Resource B', icon: null);

    final parameter = Parameter(
      capitalizedName: 'Parameter',
      initialLevel: 0,
      totalLevels: 5,
    );

    final converter = Converter(from: resourceB, to: parameter, cost: 8);

    final levelForSkipQuantity = generation.finalLevel - 1;
    final levelForSkipProduction = generation.finalLevel - 2;
    final resourceTree = SpanningTree<Resource, CalculatorModifier>.from(
      tree: List.from([
        SpanningTreeElement(
          vertex: resourceB,
          parent: resourceA,
          cost: 3,
          weightToParent: 3,
          additionalInfo: null,
        ),
        SpanningTreeElement(
          vertex: resourceA,
          parent: null,
          cost: 0,
          weightToParent: null,
          additionalInfo: CalculatorModifier(
            shouldSkipQuantity: () => (
              generation.currentLevel == levelForSkipQuantity
            ),
            shouldSkipProduction: () => (
              generation.currentLevel == levelForSkipProduction
            ),
          ),
        ),
      ]),
    );

    final calculatorA = Calculator(
      resource: resourceA,
      converter: converter,
      resourceTree: resourceTree,
    );

    final calculatorB = Calculator(
      resource: resourceB,
      converter: converter,
      resourceTree: resourceTree,
    );

    tearDown(() {
      generation.currentLevel = generation.initialLevel;
      parameter.currentLevel = parameter.initialLevel;
      resourceA.quantity = 0;
      resourceA.production = 0;
      resourceB.quantity = 0;
      resourceB.production = 0;
    });

    test('Should be created with right values', () {
      expect(calculatorA.targetName, equals(parameter.capitalizedName));
      expect(calculatorA.resource, equals(resourceA));
      expect(calculatorA.conversionCost, equals(3));
      expect(calculatorA.missingQuantity, equals(14));
      expect(calculatorA.missingProduction, equals(2));

      expect(calculatorB.targetName, equals(parameter.capitalizedName));
      expect(calculatorB.resource, equals(resourceB));
      expect(calculatorB.conversionCost, equals(8));
      expect(calculatorB.missingQuantity, equals(40));
      expect(calculatorB.missingProduction, equals(4));
    });

    test('Should be recalculated when generation changes', () {
      generation.currentLevel = 10;

      expect(calculatorA.missingQuantity, equals(14));
      expect(calculatorA.missingProduction, equals(4));

      expect(calculatorB.missingQuantity, equals(40));
      expect(calculatorB.missingProduction, equals(10));
    });

    test('Should be recalculated when generation reaches final level', () {
      generation.currentLevel = generation.finalLevel;

      expect(calculatorA.missingQuantity, equals(14));
      expect(calculatorA.missingProduction, equals(0));

      expect(calculatorB.missingQuantity, equals(40));
      expect(calculatorB.missingProduction, equals(0));
    });

    test('Should be recalculated when parameter changes', () {
      parameter.currentLevel = 3;

      expect(calculatorA.missingQuantity, equals(6));
      expect(calculatorA.missingProduction, equals(1));

      expect(calculatorB.missingQuantity, equals(16));
      expect(calculatorB.missingProduction, equals(2));
    });

    test('Should be recalculated when parameter reaches final level', () {
      parameter.currentLevel = parameter.finalLevel;

      expect(calculatorA.missingQuantity, equals(0));
      expect(calculatorA.missingProduction, equals(0));

      expect(calculatorB.missingQuantity, equals(0));
      expect(calculatorB.missingProduction, equals(0));
    });

    test('Should be recalculated when generation and parameter changes', () {
      generation.currentLevel = 11;
      parameter.currentLevel = 2;

      expect(calculatorA.missingQuantity, equals(8));
      expect(calculatorA.missingProduction, equals(3));

      expect(calculatorB.missingQuantity, equals(24));
      expect(calculatorB.missingProduction, equals(8));
    });

    test('Should be recalculated when resources quantity changes', () {
      resourceA.quantity = 5;
      resourceB.quantity = 18;

      expect(calculatorA.missingQuantity, equals(3));
      expect(calculatorA.missingProduction, equals(1));

      expect(calculatorB.missingQuantity, equals(7));
      expect(calculatorB.missingProduction, equals(1));
    });

    test('Should be recalculated when resources production changes', () {
      resourceA.production = 2;
      resourceB.production = 1;

      expect(calculatorA.missingQuantity, equals(14));
      expect(calculatorA.missingProduction, equals(0));

      expect(calculatorB.missingQuantity, equals(40));
      expect(calculatorB.missingProduction, equals(3));
    });

    test('Should return negative values when have extra amounts', () {
      parameter.currentLevel = parameter.finalLevel;
      resourceA.quantity = 4;
      resourceA.production = 2;
      resourceB.quantity = 9;
      resourceB.production = 3;

      expect(calculatorA.missingQuantity, equals(-4));
      expect(calculatorA.missingProduction, equals(-2));

      expect(calculatorB.missingQuantity, equals(-9));
      expect(calculatorB.missingProduction, equals(-3));
    });

    group('Modifier', () {
      setUp(() {
        resourceA.quantity = 4;
        resourceA.production = 2;
        resourceB.quantity = 9;
        resourceB.production = 3;
      });

      test('Should return negative production when shouldSkipProduction returns true', () {
        generation.currentLevel = levelForSkipProduction;

        expect(calculatorA.missingQuantity, equals(7));
        expect(calculatorA.missingProduction, equals(-2));

        expect(calculatorB.missingQuantity, equals(19));
        expect(calculatorB.missingProduction, equals(7));
      });

      test('Should return negative values when shouldSkipQuantity returns true', () {
        generation.currentLevel = levelForSkipQuantity;

        expect(calculatorA.missingQuantity, equals(-4));
        expect(calculatorA.missingProduction, equals(-2));

        expect(calculatorB.missingQuantity, equals(31));
        expect(calculatorB.missingProduction, equals(28));
      });
    });
  });
}
