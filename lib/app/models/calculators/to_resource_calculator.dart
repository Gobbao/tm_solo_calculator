import 'package:flutter/material.dart';

import 'to_parameter_calculator.dart';
import '../generation.dart';
import '../resource.dart';
import 'calculator.dart';

class ToResourceCalculator extends Calculator {
  final ToParameterCalculator calculator;

  ToResourceCalculator({
    @required this.calculator,
    @required Resource resource,
    @required Generation generation,
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
  int get conversionCost => super.conversionCost * calculator.conversionCost;

  @override
  String get conversionTargetCapitalizedName =>
    '${calculator.parameter.capitalizedName} (${calculator.resource.capitalizedName})';

  @override
  int get remainingQuantity {
    if (calculator.remainingQuantity < 0) return -resource.quantity;

    return
      applyModifiersFor(
        CalculatorModifierTarget.remainingQuantity,
        calculator.remainingQuantity * super.conversionCost - resource.quantity,
      )
      .ceil();
  }
}
