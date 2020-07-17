import 'package:flutter/foundation.dart';

import '../converter.dart';
import '../graph/spanning_tree_element.dart';
import '../parameters/generation.dart';
import '../resources/resource.dart';

class Calculator {
  final Resource resource;
  final int conversionCost;
  final int _bonus;
  final Converter _converter;
  final List<SpanningTreeElement<Resource>> _resourceTree;

  Calculator({
    @required this.resource,
    @required Converter converter,
    @required List<SpanningTreeElement<Resource>> resourceTree,
  })
    : _converter = converter
    , _resourceTree = resourceTree
    , _bonus = _calculateBonus(tree: resourceTree, resource: resource)
    , conversionCost = _calculateConversionCost(
      tree: resourceTree,
      resource: resource,
      initialCost: converter.cost.toDouble(),
    );

  String get targetName => _converter.to.capitalizedName;

  int get missingQuantity {
    if (_converter.to.isLastLevel) return -resource.quantity;

    final necessaryQuantity = _converter.to.remainingLevels * _converter.cost;
    final equivalentQuantity = _resourceTree
      .reversed
      .fold<int>(0, (previousValue, element) => (
        previousValue * (element.weightToParent ?? 1) + element.vertex.quantity
      ));

    return ((necessaryQuantity - equivalentQuantity) / _bonus).ceil();
  }

  int get missingProduction {
    if (generation.isLastLevel) return -resource.production;
    if (missingQuantity <= 0) return -resource.production;

    return
      (missingQuantity / generation.remainingLevels - resource.production)
      .ceil();
  }
}

int _calculateBonus({
  @required List<SpanningTreeElement<Resource>> tree,
  @required Resource resource,
}) {
  int bonus = 1;

  for (final treeElement in tree) {
    if (treeElement.vertex == resource) return bonus;

    bonus *= treeElement.weightToParent;
  }

  return bonus;
}

int _calculateConversionCost({
  @required List<SpanningTreeElement<Resource>> tree,
  @required Resource resource,
  @required double initialCost,
}) {
  double cost = initialCost;

  for (final treeElement in tree) {
    if (treeElement.vertex == resource) return cost.ceil();

    cost /= treeElement.weightToParent;
  }

  return cost.ceil();
}
