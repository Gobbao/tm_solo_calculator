import 'parameter.dart';

final Ocean ocean = Ocean._();

class Ocean extends Parameter {
  Ocean._() : super(
    capitalizedName: 'Ocean',
    initialLevel: 0,
    totalLevels: 9,
  );
}
