import 'package:flutter_test/flutter_test.dart';
import 'package:tm_solo_calculator/app/models/graph/directed_graph.dart';
import 'package:tm_solo_calculator/app/models/graph/edge.dart';

import '../../matchers/spanning_tree_element.dart';

void main() {
  group('Directed Graph', () {
    final graph = DirectedGraph<String>();

    test('Should add edge', () {
      final edgeAToB = Edge('A', 'B', 2);
      final edgeAToC = Edge('A', 'C', 3);
      final edgeCToB = Edge('C', 'B', 1);
      final edgeBToD = Edge('B', 'D', 1);

      graph
        ..addEdge(edgeAToB)
        ..addEdge(edgeAToC)
        ..addEdge(edgeCToB)
        ..addEdge(edgeBToD);

      expect(
          graph.adjacencyList,
          equals({
            'A': [edgeAToB, edgeAToC],
            'B': [edgeBToD],
            'C': [edgeCToB],
            'D': [],
          }));
    });

    test('Should generate longest paths', () {
      final longestPaths = graph.findLongestPaths();
      final tree = longestPaths.tree;

      expect(tree, hasLength(4));
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
              'parent': equals('C'),
              'cost': equals(4),
              'weightToParent': equals(1),
            })),
            SpanningTreeElementMatcher(equals({
              'vertex': equals('C'),
              'parent': equals('A'),
              'cost': equals(3),
              'weightToParent': equals(3),
            })),
            SpanningTreeElementMatcher(equals({
              'vertex': equals('D'),
              'parent': equals('B'),
              'cost': equals(5),
              'weightToParent': equals(1),
            })),
          ]));
    });
  });
}
