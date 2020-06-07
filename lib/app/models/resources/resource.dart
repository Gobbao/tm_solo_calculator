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

  @override
  int get hashCode {
    int result = 17;
    result = 37 * result + capitalizedName.hashCode;

    return result;
  }

  @override
  bool operator ==(dynamic other) {
    if (other is! Resource) return false;

    Resource resource = other;

    return resource.capitalizedName == capitalizedName;
  }

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
