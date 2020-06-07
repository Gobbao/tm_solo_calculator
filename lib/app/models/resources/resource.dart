import 'package:flutter/material.dart';

class Resource {
  final String capitalizedName;
  final IconData icon;
  final int _minProduction;

  int _quantity = 0;
  int _production = 0;

  Resource({
    @required this.capitalizedName,
    @required this.icon,
    int minProduction = 0,
  })
    : _minProduction = minProduction;

  int get quantity => _quantity;

  set quantity(int value) {
    if (value == null || value == quantity) return;

    _quantity = value < 0 ? 0 : value;
  }

  int get production => _production;

  set production(int value) {
    if (value == null || value == production) return;

    _production = value < _minProduction ? _minProduction : value;
  }
}
