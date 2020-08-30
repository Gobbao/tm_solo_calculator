import 'package:flutter_test/flutter_test.dart';
import 'package:tm_solo_calculator/app/models/graph/depth_first_search.dart';
import 'package:tm_solo_calculator/app/models/graph/edge.dart';

void main() {
  group('Depth First Search', () {
    final dfs = DepthFirstSearch({
      'A': [Edge('A', 'B', 0), Edge('A', 'C', 0)],
      'B': [Edge('B', 'D', 0)],
      'C': [Edge('C', 'D', 0)],
      'D': [Edge('D', 'E', 0)],
      'E': [],
    });

    test('Should generate spanning tree in the right order', () {
      final spanningTree = dfs.generateSpanningTree();
      final expectedResult = ['E', 'D', 'B', 'C', 'A'];

      expect(spanningTree, equals(expectedResult));
    });
  });
}
