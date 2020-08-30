import 'package:flutter/foundation.dart';

import 'depth_first_search.dart';
import 'edge.dart';
import 'spanning_tree.dart';

class DirectedGraph<T, S> {
  final Map<T, List<Edge<T, S>>> adjacencyList = {};

  void addEdge(Edge<T, S> edge) {
    if (!adjacencyList.containsKey(edge.destination)) {
      adjacencyList[edge.destination] = [];
    }

    if (adjacencyList.containsKey(edge.source)) {
      adjacencyList[edge.source].add(edge);

      return;
    }

    adjacencyList[edge.source] = [edge];
  }

  SpanningTree<T, S> findLongestPaths() {
    final parents = Map<T, T>();
    final costToGetTo = Map<T, double>();
    final dfsSpanningTree = DepthFirstSearch(adjacencyList)
      .generateSpanningTree()
      .reversed;

    adjacencyList.forEach((key, _) {
      parents.putIfAbsent(key, () => null);
      costToGetTo.putIfAbsent(key, () => double.infinity);
    });

    dfsSpanningTree.forEach((vertex) {
      if (costToGetTo[vertex] == double.infinity) {
        costToGetTo[vertex] = 0;
      }

      adjacencyList[vertex].forEach((edge) {
        final weight = edge.weight * -1;
        final destination = edge.destination;
        final costToGetToDestination = costToGetTo[vertex] + weight;

        if (costToGetToDestination < costToGetTo[destination]) {
          costToGetTo[destination] = costToGetToDestination;
          parents[destination] = vertex;
        }
      });
    });

    return _buildSpanningTree(costToGetTo: costToGetTo, parents: parents);
  }

  SpanningTree<T, S> _buildSpanningTree({
    @required Map<T, double> costToGetTo,
    @required Map<T, T> parents,
  }) {
    final costs = Map<T, int>();
    final weights = Map<T, int>();
    final additionalInfos = Map<T, S>();
    final children = parents.map((key, value) => MapEntry(value, key));

    for (final entry in costToGetTo.entries) {
      final key = entry.key;
      final parent = parents[key];
      final child = children[key];
      final parentEdge = (parent != null)
        ? adjacencyList[parent].firstWhere((e) => e.destination == key)
        : null;
      final childEdge = (child != null)
        ? adjacencyList[key].firstWhere((e) => e.destination == child)
        : null;

      costs.putIfAbsent(key, () => entry.value.toInt() * -1);
      weights.putIfAbsent(key, () => parentEdge?.weight);
      additionalInfos.putIfAbsent(key, () => childEdge?.additionalInfo);
    }

    return SpanningTree<T, S>(
      costs: costs,
      parents: parents,
      weights: weights,
      additionalInfos: additionalInfos,
    );
  }
}
