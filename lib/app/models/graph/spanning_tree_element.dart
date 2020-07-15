import 'package:flutter/foundation.dart';

class SpanningTreeElement<T> {
  final T vertex;
  final T parent;
  final int cost;
  final int weightToParent;

  SpanningTreeElement({
    @required this.vertex,
    @required this.parent,
    @required this.cost,
    @required this.weightToParent,
  });
}
