import 'package:flutter/material.dart';

import 'resource.dart';

final Heat heat = Heat._();

class Heat extends Resource {
  Heat._() : super(
    capitalizedName: 'Heat',
    icon: Icons.wb_sunny,
  );
}
