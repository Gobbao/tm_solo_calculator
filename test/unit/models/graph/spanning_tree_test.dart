import 'package:flutter_test/flutter_test.dart';
import 'package:tm_solo_calculator/app/models/graph/spanning_tree.dart';

import '../../../matchers/spanning_tree_element.dart';

void main() {
  group('Depth First Search', () {
    final spanningTree = SpanningTree(
      costs: {
        'A': 0,
        'B': 4,
        'C': 12,
      },
      weights: {
        'A': null,
        'B': 4,
        'C': 8,
      },
      parents: {
        'A': null,
        'B': 'A',
        'C': 'B',
      },
    );

    test('Should generate spanning tree correctly', () {
      final tree = spanningTree.tree;

      expect(tree, hasLength(3));
      expect(
        tree,
        containsAll([
          SpanningTreeElementMatcher(equals({
            'vertex': equals('A'),
            'parent': isNull,
            'cost': isZero,
            'weightToParent': isNull,
          })),
          SpanningTreeElementMatcher(equals({
            'vertex': equals('B'),
            'parent': equals('A'),
            'cost': equals(4),
            'weightToParent': equals(4),
          })),
          SpanningTreeElementMatcher(equals({
            'vertex': equals('C'),
            'parent': equals('B'),
            'cost': equals(12),
            'weightToParent': equals(8),
          })),
        ]),
      );
    });

    test('Should generate subtree correctly', () {
      final subtree = spanningTree.generateSubtreeFrom('B');

      expect(subtree, hasLength(2));
      expect(
        subtree,
        containsAllInOrder([
          SpanningTreeElementMatcher(equals({
            'vertex': equals('B'),
            'parent': equals('A'),
            'cost': equals(4),
            'weightToParent': equals(4),
          })),
          SpanningTreeElementMatcher(equals({
            'vertex': equals('A'),
            'parent': isNull,
            'cost': isZero,
            'weightToParent': isNull,
          })),
        ]),
      );
    });
  });
}
