import 'package:flutter/foundation.dart';

import 'spanning_tree_element.dart';

class SpanningTree<T> {
  final List<SpanningTreeElement<T>> tree;

  SpanningTree({
    @required Map<T, int> costs,
    @required Map<T, int> weights,
    @required Map<T, T> parents,
  })
    : tree = costs.entries.map(
      (e) => SpanningTreeElement<T>(
        vertex: e.key,
        parent: parents[e.key],
        cost: e.value,
        weightToParent: weights[e.key],
      )
    ).toList();

  List<SpanningTreeElement<T>> generateSubtreeFrom(T source) {
    final subtree = List<SpanningTreeElement<T>>();
    final firstElement = tree.firstWhere(
      (element) => element.vertex == source,
      orElse: () => SpanningTreeElement<T>(
        vertex: source,
        parent: null,
        cost: 0,
        weightToParent: null,
      ),
    );

    subtree.add(firstElement);

    while (true) {
      final lastFoundElement = subtree.last;

      if (lastFoundElement.parent == null) {
        break;
      }

      final parentElement = tree.firstWhere(
        (element) => element.vertex == lastFoundElement.parent,
      );

      subtree.add(parentElement);
    }

    return subtree;
  }
}
