import 'package:flutter/material.dart';

import 'models/calculators/calculator.dart';
import 'models/calculators/to_parameter_calculator.dart';
import 'models/parameters/generation.dart' as GenerationParameter;
import 'models/parameters/parameter.dart';
import 'models/resources/energy.dart';
import 'models/resources/heat.dart';
import 'models/resources/mega_credit.dart';
import 'models/resources/plant.dart';
import 'models/resources/resource.dart';

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
  final Map<ResourceKey, Resource> resources = _resources;
  final Map<ResourceKey, List<Calculator>> calculatorsGroupedByResource = _calculators;

  void notifyUpdate() {
    notifyListeners();
  }
}

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
  ResourceKey.megaCredit: megaCredit,
  ResourceKey.plant: plant,
  ResourceKey.heat: heat,
  ResourceKey.energy: energy,
};

Map<ParameterKey, Calculator> _megaCreditCalculators = {
  ParameterKey.ocean: ToParameterCalculator(
    generation: GenerationParameter.generation,
    resource: _resources[ResourceKey.megaCredit],
    parameter: _parameters[ParameterKey.ocean],
    conversionCost: 18,
  ),
  ParameterKey.oxygen: ToParameterCalculator(
    generation: GenerationParameter.generation,
    resource: _resources[ResourceKey.megaCredit],
    parameter: _parameters[ParameterKey.oxygen],
    conversionCost: 23,
  ),
  ParameterKey.temperature: ToParameterCalculator(
    generation: GenerationParameter.generation,
    resource: _resources[ResourceKey.megaCredit],
    parameter: _parameters[ParameterKey.temperature],
    conversionCost: 14,
  ),
};

Map<ParameterKey, Calculator> _plantCalculators = {
  ParameterKey.oxygen: ToParameterCalculator(
    generation: GenerationParameter.generation,
    resource: _resources[ResourceKey.plant],
    parameter: _parameters[ParameterKey.oxygen],
    conversionCost: 8,
  ),
};

Map<ParameterKey, Calculator> _heatCalculators = {
  ParameterKey.temperature: ToParameterCalculator(
    generation: GenerationParameter.generation,
    resource: _resources[ResourceKey.heat],
    parameter: _parameters[ParameterKey.temperature],
    conversionCost: 8,
  ),
};

Map<ParameterKey, Calculator> _energyCalculators = {
  ParameterKey.temperature: ToParameterCalculator(
    generation: GenerationParameter.generation,
    resource: _resources[ResourceKey.energy],
    parameter: _parameters[ParameterKey.temperature],
    conversionCost: 8,
  ),
};

Map<ResourceKey, List<Calculator>> _calculators = {
  ResourceKey.megaCredit: List.from(_megaCreditCalculators.values),
  ResourceKey.plant: List.from(_plantCalculators.values),
  ResourceKey.heat: List.from(_heatCalculators.values),
  ResourceKey.energy: List.from(_energyCalculators.values),
};
