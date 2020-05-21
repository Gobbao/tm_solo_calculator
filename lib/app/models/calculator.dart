import 'generation.dart';
import 'parameter.dart';
import 'resource.dart';

class Calculator {
  final Resource resource;
  final Parameter parameter;
  final Generation generation;
  final int conversionCost;

  Calculator({
    this.resource,
    this.parameter,
    this.generation,
    this.conversionCost,
  });

  int get remainingCost {
    return parameter.remainingLevels * conversionCost - resource.quantity;
  }

  int get remainingProduction {
    if (generation.remainingLevels == 0) return -resource.production;

    return (remainingCost / generation.remainingLevels - resource.production).ceil();
  }
}
