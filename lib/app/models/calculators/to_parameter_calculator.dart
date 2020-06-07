import 'package:flutter/material.dart';

import '../generation.dart';
import '../parameter.dart';
import '../resources/resource.dart';
import 'calculator.dart';

class ToParameterCalculator extends Calculator {
  final Generation generation;
  final Resource resource;
  final Parameter parameter;
  final int _conversionCost;

  ToParameterCalculator({
    @required this.generation,
    @required this.resource,
    @required this.parameter,
    @required int conversionCost,
  }) : _conversionCost = conversionCost;

  @override
  String get targetName => parameter.capitalizedName;

  @override
  int get conversionCost => _conversionCost;

  @override
  int get remainingQuantity => (
    (parameter.remainingLevels * conversionCost - resource.quantity)
    .ceil()
  );

  @override
  int get remainingProduction {
    if (generation.isLastLevel) return -resource.production;
    if (remainingQuantity <= 0) return -resource.production;

    return
      (remainingQuantity / generation.remainingLevels - resource.production)
      .ceil();
  }
}
