import '../models/calculators/calculator.dart';
import '../models/calculators/modifier.dart';
import '../models/converter.dart';
import '../models/graph/directed_graph.dart';
import '../models/graph/edge.dart';
import '../models/parameters/generation.dart';
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
  final _resourceGraph = DirectedGraph<Resource, CalculatorModifier>();
  final _converters = Map<Resource, Map<Parameter, int>>();

  ConverterState() {
    addResourceConverter(energy, heat, 1, CalculatorModifier(
      shouldSkipQuantity: () => generation.isLastLevel,
      shouldSkipProduction: () => (
        generation.currentLevel == generation.finalLevel - 1
      ),
    ));

    addParameterConverter(megaCredit, ocean, 18);
    addParameterConverter(megaCredit, oxygen, 23);
    addParameterConverter(megaCredit, temperature, 14);
    addParameterConverter(plant, oxygen, 8);
    addParameterConverter(heat, temperature, 8);
  }

  void addResourceConverter(
    Resource source,
    Resource destination,
    int bonus,
    [CalculatorModifier modifier]
  ) {
    _resourceGraph.addEdge(Edge(source, destination, bonus, modifier));
  }

  void addParameterConverter(Resource source, Parameter destination, int cost) {
    _converters.putIfAbsent(source, () => Map<Parameter, int>());
    _converters[source].update(destination, (_) => cost, ifAbsent: () => cost);
  }

  List<Calculator> generateCalculators() {
    final tree = _resourceGraph.findLongestPaths();
    final calculators = List<Calculator>();

    _converters.forEach((resource, converters) {
      final subtree = tree.generateSubtreeFrom(resource);

      converters.forEach((parameter, cost) {
        subtree.tree.forEach((element) {
          calculators.add(Calculator(
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
