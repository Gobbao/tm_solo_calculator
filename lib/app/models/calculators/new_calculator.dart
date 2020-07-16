import 'package:flutter/foundation.dart';

import '../../models/parameters/generation.dart';
import '../converter.dart';
import '../graph/spanning_tree_element.dart';
import '../resources/resource.dart';
import 'calculator.dart';

// TODO: rename to Calculator and delete the abstract class
class NewCalculator extends Calculator {
  final Resource resource;
  final Converter _converter;
  final List<SpanningTreeElement<Resource>> _resourceTree;

  NewCalculator({
    @required this.resource,
    @required Converter converter,
    @required List<SpanningTreeElement<Resource>> resourceTree,
  })
    : _converter = converter
    , _resourceTree = resourceTree;

  @override
  String get targetName => _converter.to.capitalizedName;

  // TODO: change to class variable instead of getter
  @override
  int get conversionCost {
    double cost = _converter.cost.toDouble();

    for (final treeElement in _resourceTree) {
      if (treeElement.vertex == resource) return cost.ceil();

      cost /= treeElement.weightToParent;
    }

    return cost.ceil();
  }

  // TODO: change to class variable instead of getter
  int get _bonus {
    int bonus = 1;

    for (final treeElement in _resourceTree) {
      if (treeElement.vertex == resource) return bonus;

      bonus *= treeElement.weightToParent;
    }

    return bonus;
  }

  @override
  int get remainingQuantity {
    if (_converter.to.isLastLevel) return -resource.quantity;

    final necessaryQuantity = _converter.to.remainingLevels * _converter.cost;
    final equivalentQuantity = _resourceTree
      .reversed
      .fold<int>(0, (previousValue, element) => (
        previousValue * (element.weightToParent ?? 1) + element.vertex.quantity
      ));

    return ((necessaryQuantity - equivalentQuantity) / _bonus).ceil();
  }

  @override
  int get remainingProduction {
    if (generation.isLastLevel) return -resource.production;
    if (remainingQuantity <= 0) return -resource.production;

    return
      (remainingQuantity / generation.remainingLevels - resource.production)
      .ceil();
  }
}
