import 'parameter.dart';

final Generation generation = Generation._();

class Generation extends Parameter {
  Generation._() : super(
    capitalizedName: 'Generation',
    initialLevel: 1,
    totalLevels: 13,
  );
}
