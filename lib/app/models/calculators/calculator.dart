import 'package:flutter/foundation.dart';

import '../converter.dart';
import '../graph/spanning_tree.dart';
import '../parameters/generation.dart';
import '../resources/resource.dart';
import 'modifier.dart';

class Calculator {
  final Resource resource;
  final int conversionCost;
  final int _bonus;
  final Converter _converter;
  final SpanningTree<Resource, CalculatorModifier> _resourceTree;
  final SpanningTree<Resource, CalculatorModifier> _childrenResourceTree;

  Calculator({
    @required this.resource,
    @required Converter converter,
    @required SpanningTree<Resource, CalculatorModifier> resourceTree,
  })
    : _converter = converter
    , _resourceTree = resourceTree
    , _childrenResourceTree = resourceTree.generateChildrenSubtreeFrom(resource)
    , _bonus = _calculateBonus(resourceTree: resourceTree, resource: resource)
    , conversionCost = _calculateConversionCost(
      resourceTree: resourceTree,
      resource: resource,
      initialCost: converter.cost.toDouble(),
    );

  String get targetName => _converter.to.capitalizedName;

  bool get _shouldSkipQuantity {
    final shouldSkipFromModifiers = _childrenResourceTree.tree.any(
      (element) => element.additionalInfo?.shouldSkipQuantity() ?? false
    );

    return _converter.to.isLastLevel || shouldSkipFromModifiers;
  }

  int get missingQuantity {
    if (_shouldSkipQuantity) return -resource.quantity;

    final necessaryQuantity = _converter.to.missingLevels * _converter.cost;
    final equivalentQuantity = _resourceTree.tree
      .reversed
      .fold<int>(0, (previousValue, element) {
        final quantity = (element.additionalInfo?.shouldSkipQuantity() ?? false)
          ? 0
          : element.vertex.quantity;

        return previousValue * (element.weightToParent ?? 1) + quantity;
      });

    return ((necessaryQuantity - equivalentQuantity) / _bonus).ceil();
  }

  bool get _shouldSkipProduction {
    final shouldSkipFromModifiers = _childrenResourceTree.tree.any(
      (element) => element.additionalInfo?.shouldSkipProduction() ?? false
    );

    return
      generation.isLastLevel
      || missingQuantity <= 0
      || shouldSkipFromModifiers;
  }

  int get missingProduction {
    if (_shouldSkipProduction) return -resource.production;

    return
      (missingQuantity / generation.missingLevels - resource.production)
      .ceil();
  }
}

int _calculateBonus({
  @required SpanningTree<Resource, CalculatorModifier> resourceTree,
  @required Resource resource,
}) {
  int bonus = 1;

  for (final treeElement in resourceTree.tree) {
    if (treeElement.vertex == resource) return bonus;

    bonus *= treeElement.weightToParent;
  }

  return bonus;
}

int _calculateConversionCost({
  @required SpanningTree<Resource, CalculatorModifier> resourceTree,
  @required Resource resource,
  @required double initialCost,
}) {
  double cost = initialCost;

  for (final treeElement in resourceTree.tree) {
    if (treeElement.vertex == resource) return cost.ceil();

    cost /= treeElement.weightToParent;
  }

  return cost.ceil();
}
