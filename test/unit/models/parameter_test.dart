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
      expect(parameter.initialLevel, 0);
      expect(parameter.totalLevels, 3);
      expect(parameter.finalLevel, 3);
      expect(parameter.measureUnit, null);
      expect(parameter.currentLevel, 0);
      expect(parameter.formatedCurrentLevel, '0');
      expect(parameter.remainingLevels, 3);
      expect(parameter.isFirstLevel, true);
      expect(parameter.isLastLevel, false);
    });

    test('Level should not be lower than initial level', () {
      parameter.currentLevel = parameter.initialLevel - 1;

      expect(parameter.currentLevel, parameter.initialLevel);
      expect(parameter.formatedCurrentLevel, '0');
      expect(parameter.remainingLevels, 3);
      expect(parameter.isFirstLevel, true);
      expect(parameter.isLastLevel, false);
    });

    test('Level should be incremented', () {
      parameter.incrementLevel();
      parameter.incrementLevel();

      expect(parameter.currentLevel, 2);
      expect(parameter.formatedCurrentLevel, '2');
      expect(parameter.remainingLevels, 1);
      expect(parameter.isFirstLevel, false);
      expect(parameter.isLastLevel, false);
    });

    test('Level should be decremented', () {
      parameter.decrementLevel();

      expect(parameter.currentLevel, 1);
      expect(parameter.formatedCurrentLevel, '1');
      expect(parameter.remainingLevels, 2);
      expect(parameter.isFirstLevel, false);
      expect(parameter.isLastLevel, false);
    });

    test('Level should not be greater than final level', () {
      parameter.currentLevel = parameter.finalLevel + 1;

      expect(parameter.currentLevel, parameter.finalLevel);
      expect(parameter.formatedCurrentLevel, '3');
      expect(parameter.remainingLevels, 0);
      expect(parameter.isFirstLevel, false);
      expect(parameter.isLastLevel, true);
    });

    test('Should consider level multiplier', () {
      final _parameter = Parameter(
        capitalizedName: 'Parameter',
        initialLevel: 1,
        totalLevels: 2,
        levelMultiplier: 3,
      );

      expect(_parameter.initialLevel, 1);
      expect(_parameter.finalLevel, 7);
      expect(_parameter.currentLevel, 1);

      _parameter.incrementLevel();
      expect(_parameter.currentLevel, 4);

      _parameter.incrementLevel();
      expect(_parameter.currentLevel, 7);
    });

    test('Should consider measure unit', () {
      final _parameter = Parameter(
        capitalizedName: 'Parameter',
        measureUnit: '%',
        initialLevel: 0,
        totalLevels: 3,
      );

      expect(_parameter.formatedCurrentLevel, '0 %');

      _parameter.incrementLevel();
      expect(_parameter.formatedCurrentLevel, '1 %');
    });

    test('Should consider plus signal', () {
      final _parameter = Parameter(
        capitalizedName: 'Parameter',
        enablePlusSignalOnFormatting: true,
        initialLevel: 0,
        totalLevels: 3,
      );

      expect(_parameter.formatedCurrentLevel, '0');

      _parameter.incrementLevel();
      expect(_parameter.formatedCurrentLevel, '+1');
    });

    test('Should consider measure unit and plus signal', () {
      final _parameter = Parameter(
        capitalizedName: 'Parameter',
        measureUnit: '%',
        enablePlusSignalOnFormatting: true,
        initialLevel: 0,
        totalLevels: 3,
      );

      expect(_parameter.formatedCurrentLevel, '0 %');

      _parameter.incrementLevel();
      expect(_parameter.formatedCurrentLevel, '+1 %');
    });
  });
}
