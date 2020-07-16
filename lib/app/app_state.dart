import 'package:flutter/material.dart';

import 'models/calculators/calculator.dart';
import 'models/parameters/generation.dart' as GenerationParameter;
import 'models/parameters/ocean.dart';
import 'models/parameters/oxygen.dart';
import 'models/parameters/parameter.dart';
import 'models/parameters/temperature.dart';
import 'models/resources/energy.dart';
import 'models/resources/heat.dart';
import 'models/resources/mega_credit.dart';
import 'models/resources/plant.dart';
import 'models/resources/resource.dart';
import 'state/converter.dart';

enum ParameterKey {
  ocean,
  oxygen,
  temperature,
}

enum ResourceKey {
  heat,
  megaCredit,
  plant,
  energy,
}

class AppState with ChangeNotifier {
  final GenerationParameter.Generation generation = GenerationParameter.generation;
  final Map<ParameterKey, Parameter> parameters = _parameters;
  // TODO: use Resource as key instead of ResourceKey. Transform into list?
  final Map<ResourceKey, Resource> resources = _resources;
  // TODO: improve this. Use Resource as key instead of ResourceKey.
  final Map<ResourceKey, List<Calculator>> calculatorsGroupedByResource =
    ConverterState()
      .generateCalculators()
      .fold(Map(), (previousValue, element) {
        final resourceName = element.resource.capitalizedName;
        final resourceKey = resourceName == 'Mega credit'
          ? ResourceKey.megaCredit
          : resourceName == 'Plant'
            ? ResourceKey.plant
            : resourceName == 'Heat'
              ? ResourceKey.heat
              : ResourceKey.energy;

        previousValue.update(
          resourceKey,
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

Map<ResourceKey, Resource> _resources = {
  ResourceKey.megaCredit: megaCredit,
  ResourceKey.plant: plant,
  ResourceKey.heat: heat,
  ResourceKey.energy: energy,
};
