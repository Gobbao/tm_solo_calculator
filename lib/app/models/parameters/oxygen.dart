import 'parameter.dart';

final Oxygen oxygen = Oxygen._();

class Oxygen extends Parameter {
  Oxygen._() : super(
    capitalizedName: 'Oxygen',
    measureUnit: '%',
    initialLevel: 0,
    totalLevels: 14,
  );
}
