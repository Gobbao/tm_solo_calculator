import 'package:flutter/material.dart';

import '../generation.dart';
import '../resource.dart';

typedef CalculatorModifier = num Function(num value, Calculator calculator);

enum CalculatorModifierTarget {
  remainingQuantity,
  remainingProduction,
}

abstract class Calculator {
  final Resource resource;
  final Generation generation;
  final int _conversionCost;
  final Map<CalculatorModifierTarget, List<CalculatorModifier>> modifiers;

  Calculator({
    @required this.resource,
    @required this.generation,
    @required int conversionCost,
    this.modifiers = const {},
  })
    : _conversionCost = conversionCost;

  int get conversionCost => _conversionCost;

  String get conversionTargetCapitalizedName;

  int get remainingQuantity;

  int get remainingProduction {
    if (generation.remainingLevels == 0) return -resource.production;
    if (remainingQuantity <= 0) return -resource.production;

    return
      applyModifiersFor(
        CalculatorModifierTarget.remainingProduction,
        remainingQuantity / generation.remainingLevels - resource.production,
      )
      .ceil();
  }

  num applyModifiersFor(CalculatorModifierTarget target, num initialValue) {
    final modifiersForTarget = modifiers[target];

    if (modifiersForTarget == null || modifiersForTarget.isEmpty) {
      return initialValue;
    }

    return modifiersForTarget.fold(
      initialValue,
      (previousValue, element) => element(previousValue, this),
    );
  }
}
