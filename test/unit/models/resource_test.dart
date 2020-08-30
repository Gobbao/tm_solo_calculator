import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tm_solo_calculator/app/models/resources/resource.dart';

void main() {
  group('Resource', () {
    final resource = Resource(
      capitalizedName: 'Resource',
      icon: Icons.local_florist,
      minProduction: -2,
    );

    test('Should be in initial state', () {
      expect(resource.capitalizedName, 'Resource');
      expect(resource.quantity, isZero);
      expect(resource.production, isZero);
    });

    test('Quantity should not be lower than 0', () {
      resource.quantity = -1;

      expect(resource.quantity, isZero);
      expect(resource.production, isZero);
    });

    test('Quantity should be changed', () {
      resource.quantity = 8;

      expect(resource.quantity, equals(8));
      expect(resource.production, isZero);
    });

    test('Production should not be lower than minimal production', () {
      resource.production = -3;

      expect(resource.quantity, equals(8));
      expect(resource.production, equals(-2));
    });

    test('Production should be changed', () {
      resource.production = 4;

      expect(resource.quantity, equals(8));
      expect(resource.production, equals(4));
    });

    test('Custom hash code should be equal by capitalizedName', () {
      final _resource = Resource(
        capitalizedName: resource.capitalizedName,
        icon: resource.icon,
      );

      expect(_resource, equals(resource));
      expect(resource, equals(_resource));
    });

    test('Custom hash code should be different by capitalizedName', () {
      final _resource = Resource(
        capitalizedName: 'Another resource',
        icon: resource.icon,
      );

      expect(_resource == resource, isFalse);
      expect(resource == _resource, isFalse);
    });
  });
}
