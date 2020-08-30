import 'package:flutter/material.dart';

import 'models/calculators/calculator.dart';
import 'models/parameters/generation.dart';
import 'models/parameters/ocean.dart';
import 'models/parameters/oxygen.dart';
import 'models/parameters/parameter.dart';
import 'models/parameters/temperature.dart';
import 'models/resources/resource.dart';
import 'state/converter.dart';

class AppState with ChangeNotifier {
  final parameters = List<Parameter>.from([generation, ocean, oxygen, temperature]);
  final Map<Resource, List<Calculator>> calculatorsGroupedByResource =
    ConverterState()
      .generateCalculators()
      .fold(Map(), (previousValue, element) {
        previousValue.update(
          element.resource,
          (value) => value.followedBy([element]).toList(),
          ifAbsent: () => List.from([element]),
        );

        return previousValue;
      });

  void notifyUpdate() {
    notifyListeners();
  }
}
