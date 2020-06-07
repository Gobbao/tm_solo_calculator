import '../energy.dart';
import '../heat.dart';
import '../resource.dart';
import 'converter.dart';

abstract class ResourceConverterHandler {
  static final List<ResourceConverter> converters = [
    ResourceConverter(
      fromResource: energy,
      toResource: heat,
      bonus: 1,
    ),
  ];

  static int sumQuantityByTarget(Resource resource) {
    return converters
      .where((element) => element.toResource == resource)
      .fold(0, (previousValue, element) => (
        previousValue + element.fromResource.quantity
      ));
  }
}
