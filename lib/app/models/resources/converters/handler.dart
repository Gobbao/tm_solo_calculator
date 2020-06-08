import '../resource.dart';
import 'converter.dart';
import 'energy_to_heat.dart';

abstract class ResourceConverterHandler {
  static final List<ResourceConverter> converters = [
    energyToHeatConverter,
  ];

  static int sumQuantityByTarget(Resource resource) {
    return converters
      .where((element) => element.toResource == resource)
      .fold(0, (previousValue, element) => (
        previousValue + element.fromResource.quantity * element.getBonus()
      ));
  }
}
