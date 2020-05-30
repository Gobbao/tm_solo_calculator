import 'package:flutter/material.dart';

import 'models/calculators/calculator.dart';
import 'models/calculators/to_parameter_calculator.dart';
import 'models/calculators/to_resource_calculator.dart';
import 'models/generation.dart';
import 'models/parameter.dart';
import 'models/resource.dart';

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
  ResourceKey.energy: Resource(
    capitalizedName: 'Energy',
    icon: Icons.flash_on,
  ),
};

Map<ParameterKey, Calculator> _megaCreditCalculators = {
  ParameterKey.ocean: ToParameterCalculator(
    generation: _generation,
    resource: _resources[ResourceKey.megaCredit],
    parameter: _parameters[ParameterKey.ocean],
    conversionCost: 18,
  ),
  ParameterKey.oxygen: ToParameterCalculator(
    generation: _generation,
    resource: _resources[ResourceKey.megaCredit],
    parameter: _parameters[ParameterKey.oxygen],
    conversionCost: 23,
  ),
  ParameterKey.temperature: ToParameterCalculator(
    generation: _generation,
    resource: _resources[ResourceKey.megaCredit],
    parameter: _parameters[ParameterKey.temperature],
    conversionCost: 14,
  ),
};

Map<ParameterKey, Calculator> _plantCalculators = {
  ParameterKey.oxygen: ToParameterCalculator(
    generation: _generation,
    resource: _resources[ResourceKey.plant],
    parameter: _parameters[ParameterKey.oxygen],
    conversionCost: 8,
  ),
};

Map<ParameterKey, Calculator> _heatCalculators = {
  ParameterKey.temperature: ToParameterCalculator(
    generation: _generation,
    resource: _resources[ResourceKey.heat],
    parameter: _parameters[ParameterKey.temperature],
    conversionCost: 8,
  ),
};

Map<ParameterKey, Calculator> _energyCalculators = {
  ParameterKey.temperature: ToResourceCalculator(
    generation: _generation,
    resource: _resources[ResourceKey.energy],
    calculator: _heatCalculators[ParameterKey.temperature],
    conversionCost: 1,
    modifiers: {
      CalculatorModifierTarget.remainingQuantity: List.from([
        (num value, Calculator calculator) => (
          calculator.generation.remainingLevels == 0
            ? -calculator.resource.quantity
            : value
        )
      ]),
      CalculatorModifierTarget.remainingProduction: List.from([
        (num value, Calculator calculator) {
          if (calculator.generation.remainingLevels == 1) {
            return -calculator.resource.production;
          }

          return value
            + calculator.remainingQuantity
            / (
              calculator.generation.remainingLevels
              * (calculator.generation.remainingLevels - 1)
            );
        }
      ]),
    },
  ),
};

Map<ResourceKey, List<Calculator>> _calculators = {
  ResourceKey.megaCredit: List.from(_megaCreditCalculators.values),
  ResourceKey.plant: List.from(_plantCalculators.values),
  ResourceKey.heat: List.from(_heatCalculators.values),
  ResourceKey.energy: List.from(_energyCalculators.values),
};
