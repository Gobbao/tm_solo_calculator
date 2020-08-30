class Edge<T, S> {
  final T source;
  final T destination;
  final int weight;
  final S additionalInfo;

  Edge(this.source, this.destination, this.weight, [this.additionalInfo]);
}
