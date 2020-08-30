import 'package:flutter/foundation.dart';

import 'spanning_tree_element.dart';

class SpanningTree<T, S> {
  final List<SpanningTreeElement<T, S>> tree;

  SpanningTree({
    @required Map<T, int> costs,
    @required Map<T, int> weights,
    @required Map<T, T> parents,
    @required Map<T, S> additionalInfos,
  })
    : tree = costs.entries
      .map((e) => SpanningTreeElement<T, S>(
        vertex: e.key,
        parent: parents[e.key],
        cost: e.value,
        weightToParent: weights[e.key],
        additionalInfo: additionalInfos[e.key],
      ))
      .toList();

  SpanningTree.from({
    @required this.tree,
  });

  SpanningTreeElement<T, S> _findOrCreateElement(T search) {
    return tree.firstWhere(
      (element) => element.vertex == search,
      orElse: () => SpanningTreeElement<T, S>(
        vertex: search,
        parent: null,
        cost: 0,
        weightToParent: null,
        additionalInfo: null,
      ),
    );
  }

  SpanningTree<T, S> generateSubtreeFrom(T source) {
    final subtree = List<SpanningTreeElement<T, S>>();
    final firstElement = _findOrCreateElement(source);

    subtree.add(firstElement);

    while (true) {
      final lastFoundElement = subtree.last;

      if (lastFoundElement.parent == null) break;

      final parentElement = tree.firstWhere(
        (element) => element.vertex == lastFoundElement.parent,
      );

      subtree.add(parentElement);
    }

    return SpanningTree.from(tree: subtree);
  }

  SpanningTree<T, S> generateChildrenSubtreeFrom(T source) {
    final subtree = List<SpanningTreeElement<T, S>>();
    final firstElement = _findOrCreateElement(source);

    subtree.add(firstElement);

    while (true) {
      final lastFoundElement = subtree.last;
      final childElement = tree.firstWhere(
        (element) => element.parent == lastFoundElement.vertex,
        orElse: () => null,
      );

      if (childElement == null) break;

      subtree.add(childElement);
    }

    return SpanningTree.from(tree: subtree.reversed.toList());
  }
}
