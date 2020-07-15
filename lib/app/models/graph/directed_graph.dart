import 'depth_first_search.dart';
import 'edge.dart';
import 'spanning_tree.dart';

class DirectedGraph<T> {
  final Map<T, List<Edge<T>>> adjacencyList = {};

  void addEdge(Edge<T> edge) {
    if (!adjacencyList.containsKey(edge.destination)) {
      adjacencyList[edge.destination] = [];
    }

    if (adjacencyList.containsKey(edge.source)) {
      adjacencyList[edge.source].add(edge);

      return;
    }

    adjacencyList[edge.source] = [edge];
  }

  SpanningTree<T> findLongestPaths() {
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

    return SpanningTree<T>(
      costs: costToGetTo.map((key, value) => MapEntry(key, value.toInt() * -1)),
      parents: parents,
      weights: costToGetTo.map<T, int>((key, value) {
        final parent = parents[key];

        if (parent == null) {
          return MapEntry(key, null);
        }

        final edge = adjacencyList[parent].firstWhere(
          (element) => element.destination == key,
        );

        return MapEntry(key, edge.weight);
      }),
    );
  }
}
