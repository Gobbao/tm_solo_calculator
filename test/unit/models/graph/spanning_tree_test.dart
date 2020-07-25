import 'package:flutter_test/flutter_test.dart';
import 'package:tm_solo_calculator/app/models/graph/spanning_tree.dart';

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

      expect(tree.length, equals(3));

      expect(tree[0].vertex, equals('A'));
      expect(tree[0].parent, isNull);
      expect(tree[0].cost, isZero);
      expect(tree[0].weightToParent, isNull);

      expect(tree[1].vertex, equals('B'));
      expect(tree[1].parent, equals('A'));
      expect(tree[1].cost, equals(4));
      expect(tree[1].weightToParent, equals(4));

      expect(tree[2].vertex, equals('C'));
      expect(tree[2].parent, equals('B'));
      expect(tree[2].cost, equals(12));
      expect(tree[2].weightToParent, equals(8));
    });

    test('Should generate subtree correctly', () {
      final subtree = spanningTree.generateSubtreeFrom('B');

      expect(subtree.length, equals(2));

      expect(subtree[0].vertex, equals('B'));
      expect(subtree[0].parent, equals('A'));
      expect(subtree[0].cost, equals(4));
      expect(subtree[0].weightToParent, equals(4));

      expect(subtree[1].vertex, equals('A'));
      expect(subtree[1].parent, isNull);
      expect(subtree[1].cost, isZero);
      expect(subtree[1].weightToParent, isNull);
    });
  });
}
