import 'dart:collection';

import 'edge.dart';

class DepthFirstSearch<T, S> {
  final Map<T, List<Edge<T, S>>> _adjacencyList;
  final _visited = HashSet<T>();
  final _stack = <T>[];

  DepthFirstSearch(this._adjacencyList);

  List<T> generateSpanningTree() {
    _adjacencyList.forEach((key, _) {
      if (!_visited.contains(key)) {
        _visitVertex(key);
      }
    });

    return _stack;
  }

  void _visitVertex(T vertex) {
    _visited.add(vertex);

    _adjacencyList[vertex].forEach((element) {
      final destination = element.destination;

      if (!_visited.contains(destination)) {
        _visitVertex(destination);
      }
    });

    _stack.add(vertex);
  }
}
