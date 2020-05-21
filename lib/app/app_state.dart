import 'package:flutter/material.dart';

import 'models/calculator.dart';
import 'models/generation.dart';
import 'models/resource.dart';
import 'models/parameter.dart';

enum ParameterKey {
  ocean,
  oxygen,
  temperature,
}

enum ResourceKey {
  heat,
  megaCredit,
  plant,
}

class AppState with ChangeNotifier {
  final Generation generation = _generation;
  final Map<ParameterKey, Parameter> parameters = _parameters;
  final Map<ResourceKey, Resource> resources = _resources;
  final Map<ResourceKey, List<Calculator>> calculatorsGroupedByResource = _calculators;

  void notifyUpdate() {
    notifyListeners();
  }
}

Generation _generation = Generation();

Map<ParameterKey, Parameter> _parameters = {
  ParameterKey.ocean: Parameter(
    capitalizedName: 'Ocean',
    initialLevel: 0,
    totalLevels: 9,
  ),
  ParameterKey.oxygen: Parameter(
    capitalizedName: 'Oxygen',
    measureUnit: '%',
    initialLevel: 0,
    totalLevels: 14,
  ),
  ParameterKey.temperature: Parameter(
    capitalizedName: 'Temperature',
    measureUnit: '°C',
    initialLevel: -30,
    totalLevels: 19,
    levelMultiplier: 2,
    enablePlusSignalOnFormatting: true,
  ),
};

Map<ResourceKey, Resource> _resources = {
  ResourceKey.megaCredit: Resource(
    capitalizedName: 'Mega credit',
    icon: Icons.attach_money,
    minProduction: -5,
  ),
  ResourceKey.plant: Resource(
    capitalizedName: 'Plant',
    icon: Icons.local_florist,
  ),
  ResourceKey.heat: Resource(
    capitalizedName: 'Heat',
    icon: Icons.wb_sunny,
  ),
};

Map<ResourceKey, List<Calculator>> _calculators = {
  ResourceKey.megaCredit: List.from([
    Calculator(
      generation: _generation,
      resource: _resources[ResourceKey.megaCredit],
      parameter: _parameters[ParameterKey.ocean],
      conversionCost: 18,
    ),
    Calculator(
      generation: _generation,
      resource: _resources[ResourceKey.megaCredit],
      parameter: _parameters[ParameterKey.oxygen],
      conversionCost: 23,
    ),
    Calculator(
      generation: _generation,
      resource: _resources[ResourceKey.megaCredit],
      parameter: _parameters[ParameterKey.temperature],
      conversionCost: 14,
    ),
  ]),
  ResourceKey.plant: List.from([
    Calculator(
      generation: _generation,
      resource: _resources[ResourceKey.plant],
      parameter: _parameters[ParameterKey.oxygen],
      conversionCost: 8,
    ),
  ]),
  ResourceKey.heat: List.from([
    Calculator(
      generation: _generation,
      resource: _resources[ResourceKey.heat],
      parameter: _parameters[ParameterKey.temperature],
      conversionCost: 8,
    ),
  ]),
};
