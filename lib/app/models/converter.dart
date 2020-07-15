import 'package:flutter/foundation.dart';

import 'parameters/parameter.dart';
import 'resources/resource.dart';

class Converter {
  final Resource from;
  final Parameter to;
  final int cost;

  Converter({
    @required this.from,
    @required this.to,
    @required this.cost,
  });
}
