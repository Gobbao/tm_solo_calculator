import 'package:flutter_test/flutter_test.dart';
import 'package:tm_solo_calculator/app/models/converter.dart';
import 'package:tm_solo_calculator/app/models/parameters/temperature.dart';
import 'package:tm_solo_calculator/app/models/resources/heat.dart';

void main() {
  group('Converter', () {
    final converter = Converter(from: heat, to: temperature, cost: 8);

    test('Should contain resource', () {
      expect(converter.from, heat);
    });

    test('Should contain parameter', () {
      expect(converter.to, temperature);
    });

    test('Should contain cost', () {
      expect(converter.cost, 8);
    });
  });
}
