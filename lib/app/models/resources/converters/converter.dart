import 'package:flutter/material.dart';

import '../resource.dart';

class ResourceConverter {
  final Resource fromResource;
  final Resource toResource;
  final int bonus;

  ResourceConverter({
    @required this.fromResource,
    @required this.toResource,
    @required this.bonus,
  });
}
