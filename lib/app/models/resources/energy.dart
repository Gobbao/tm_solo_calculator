import 'package:flutter/material.dart';

import 'resource.dart';

final Energy energy = Energy._();

class Energy extends Resource {
  Energy._() : super(
    capitalizedName: 'Energy',
    icon: Icons.flash_on,
  );
}
