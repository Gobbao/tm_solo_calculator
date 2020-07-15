import '../models/calculators/new_calculator.dart';
import '../models/converter.dart';
import '../models/graph/directed_graph.dart';
import '../models/graph/edge.dart';
import '../models/parameters/ocean.dart';
import '../models/parameters/oxygen.dart';
import '../models/parameters/parameter.dart';
import '../models/parameters/temperature.dart';
import '../models/resources/energy.dart';
import '../models/resources/heat.dart';
import '../models/resources/mega_credit.dart';
import '../models/resources/plant.dart';
import '../models/resources/resource.dart';

class ConverterState {
  final _resourceGraph = DirectedGraph<Resource>();
  final _converters = Map<Resource, Map<Parameter, int>>();

  ConverterState() {
    addResourceConverter(energy, heat, 1);

    addParameterConverter(megaCredit, ocean, 18);
    addParameterConverter(megaCredit, oxygen, 23);
    addParameterConverter(megaCredit, temperature, 14);
    addParameterConverter(plant, oxygen, 8);
    addParameterConverter(heat, temperature, 8);
  }

  void addResourceConverter(Resource source, Resource destination, int bonus) {
    _resourceGraph.addEdge(Edge(source, destination, bonus));
  }

  void addParameterConverter(Resource source, Parameter destination, int cost) {
    _converters.putIfAbsent(source, () => Map<Parameter, int>());
    _converters[source].update(destination, (_) => cost, ifAbsent: () => cost);
  }

  List<NewCalculator> generateCalculators() {
    final tree = _resourceGraph.findLongestPaths();
    final calculators = List<NewCalculator>();

    _converters.forEach((resource, converters) {
      final subtree = tree.generateSubtreeFrom(resource);

      converters.forEach((parameter, cost) {
        subtree.forEach((element) {
          calculators.add(NewCalculator(
            resource: element.vertex,
            resourceTree: subtree,
            converter: Converter(
              from: resource,
              to: parameter,
              cost: cost,
            ),
          ));
        });
      });
    });

    return calculators;
  }
}
