import 'package:flutter_test/flutter_test.dart';
import 'package:tm_solo_calculator/app/models/parameters/parameter.dart';

void main() {
  group('Parameter', () {
    final parameter = Parameter(
      capitalizedName: 'Parameter',
      initialLevel: 0,
      totalLevels: 3,
    );

    test('Should be in initial state', () {
      expect(parameter.capitalizedName, 'Parameter');
      expect(parameter.initialLevel, isZero);
      expect(parameter.totalLevels, equals(3));
      expect(parameter.finalLevel, equals(3));
      expect(parameter.measureUnit, isNull);
      expect(parameter.currentLevel, isZero);
      expect(parameter.formatedCurrentLevel, equals('0'));
      expect(parameter.remainingLevels, equals(3));
      expect(parameter.isFirstLevel, isTrue);
      expect(parameter.isLastLevel, isFalse);
    });

    test('Level should not be lower than initial level', () {
      parameter.currentLevel = parameter.initialLevel - 1;

      expect(parameter.currentLevel, equals(parameter.initialLevel));
      expect(parameter.formatedCurrentLevel, equals('0'));
      expect(parameter.remainingLevels, equals(3));
      expect(parameter.isFirstLevel, isTrue);
      expect(parameter.isLastLevel, isFalse);
    });

    test('Level should be incremented', () {
      parameter.incrementLevel();
      parameter.incrementLevel();

      expect(parameter.currentLevel, equals(2));
      expect(parameter.formatedCurrentLevel, equals('2'));
      expect(parameter.remainingLevels, equals(1));
      expect(parameter.isFirstLevel, isFalse);
      expect(parameter.isLastLevel, isFalse);
    });

    test('Level should be decremented', () {
      parameter.decrementLevel();

      expect(parameter.currentLevel, equals(1));
      expect(parameter.formatedCurrentLevel, equals('1'));
      expect(parameter.remainingLevels, equals(2));
      expect(parameter.isFirstLevel, isFalse);
      expect(parameter.isLastLevel, isFalse);
    });

    test('Level should not be greater than final level', () {
      parameter.currentLevel = parameter.finalLevel + 1;

      expect(parameter.currentLevel, equals(parameter.finalLevel));
      expect(parameter.formatedCurrentLevel, equals('3'));
      expect(parameter.remainingLevels, isZero);
      expect(parameter.isFirstLevel, isFalse);
      expect(parameter.isLastLevel, isTrue);
    });

    test('Should consider level multiplier', () {
      final _parameter = Parameter(
        capitalizedName: 'Parameter',
        initialLevel: 1,
        totalLevels: 2,
        levelMultiplier: 3,
      );

      expect(_parameter.initialLevel, equals(1));
      expect(_parameter.finalLevel, equals(7));
      expect(_parameter.currentLevel, equals(1));

      _parameter.incrementLevel();
      expect(_parameter.currentLevel, equals(4));

      _parameter.incrementLevel();
      expect(_parameter.currentLevel, equals(7));
    });

    test('Should consider measure unit', () {
      final _parameter = Parameter(
        capitalizedName: 'Parameter',
        measureUnit: '%',
        initialLevel: 0,
        totalLevels: 3,
      );

      expect(_parameter.formatedCurrentLevel, equals('0 %'));

      _parameter.incrementLevel();
      expect(_parameter.formatedCurrentLevel, equals('1 %'));
    });

    test('Should consider plus signal', () {
      final _parameter = Parameter(
        capitalizedName: 'Parameter',
        enablePlusSignalOnFormatting: true,
        initialLevel: 0,
        totalLevels: 3,
      );

      expect(_parameter.formatedCurrentLevel, equals('0'));

      _parameter.incrementLevel();
      expect(_parameter.formatedCurrentLevel, equals('+1'));
    });

    test('Should consider measure unit and plus signal', () {
      final _parameter = Parameter(
        capitalizedName: 'Parameter',
        measureUnit: '%',
        enablePlusSignalOnFormatting: true,
        initialLevel: 0,
        totalLevels: 3,
      );

      expect(_parameter.formatedCurrentLevel, equals('0 %'));

      _parameter.incrementLevel();
      expect(_parameter.formatedCurrentLevel, equals('+1 %'));
    });
  });
}
