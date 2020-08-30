import 'parameter.dart';

final Temperature temperature = Temperature._();

class Temperature extends Parameter {
  Temperature._() : super(
    capitalizedName: 'Temperature',
    measureUnit: '°C',
    initialLevel: -30,
    totalLevels: 19,
    levelMultiplier: 2,
    enablePlusSignalOnFormatting: true,
  );
}
