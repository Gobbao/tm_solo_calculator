import 'package:flutter/material.dart';

import '../generation.dart';
import '../parameter.dart';
import '../resource.dart';
import 'calculator.dart';

class ToParameterCalculator extends Calculator {
  final Parameter parameter;

  ToParameterCalculator({
    @required this.parameter,
    @required Generation generation,
    @required Resource resource,
    @required int conversionCost,
    Map<CalculatorModifierTarget, List<CalculatorModifier>> modifiers = const {},
  })
    : super(
      resource: resource,
      generation: generation,
      conversionCost: conversionCost,
      modifiers: modifiers,
    );

  @override
  String get conversionTargetCapitalizedName => parameter.capitalizedName;

  @override
  int get remainingQuantity {
    return
      applyModifiersFor(
        CalculatorModifierTarget.remainingQuantity,
        parameter.remainingLevels * conversionCost - resource.quantity,
      )
      .ceil();
  }
}
