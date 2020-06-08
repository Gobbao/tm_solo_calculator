import 'package:flutter/material.dart';

import 'resource.dart';

final MegaCredit megaCredit = MegaCredit._();

class MegaCredit extends Resource {
  MegaCredit._() : super(
    capitalizedName: 'Mega credit',
    icon: Icons.attach_money,
    minProduction: -5,
  );
}
