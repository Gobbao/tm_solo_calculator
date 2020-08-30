import 'package:flutter/foundation.dart';

class SpanningTreeElement<T, S> {
  final T vertex;
  final T parent;
  final int cost;
  final int weightToParent;
  final S additionalInfo;

  SpanningTreeElement({
    @required this.vertex,
    @required this.parent,
    @required this.cost,
    @required this.weightToParent,
    this.additionalInfo,
  });
}
