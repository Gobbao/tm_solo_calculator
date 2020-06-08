import 'package:flutter/material.dart';

import 'resource.dart';

final Plant plant = Plant._();

class Plant extends Resource {
  Plant._() : super(
    capitalizedName: 'Plant',
    icon: Icons.local_florist,
  );
}
