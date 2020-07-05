import '../../parameters/generation.dart';
import '../energy.dart';
import '../heat.dart';
import 'converter.dart';

final energyToHeatConverter = ResourceConverter(
  fromResource: energy,
  toResource: heat,
  getBonus: () => generation.isLastLevel ? 0 : 1,
);
