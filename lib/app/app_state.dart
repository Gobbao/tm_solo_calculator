import 'package:flutter/material.dart';

import 'models/calculators/calculator.dart';
import 'models/parameters/generation.dart' as GenerationParameter;
import 'models/parameters/ocean.dart';
import 'models/parameters/oxygen.dart';
import 'models/parameters/parameter.dart';
import 'models/parameters/temperature.dart';
import 'models/resources/resource.dart';
import 'state/converter.dart';

enum ParameterKey {
  ocean,
  oxygen,
  temperature,
}

class AppState with ChangeNotifier {
  final GenerationParameter.Generation generation = GenerationParameter.generation;
  final Map<ParameterKey, Parameter> parameters = _parameters;
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

Map<ParameterKey, Parameter> _parameters = {
  ParameterKey.ocean: ocean,
  ParameterKey.oxygen: oxygen,
  ParameterKey.temperature: temperature,
};
