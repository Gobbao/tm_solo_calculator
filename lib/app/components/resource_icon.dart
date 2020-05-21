import 'package:flutter/material.dart';

class ResourceIcon extends StatelessWidget {
  final IconData icon;
  final bool isProduction;

  ResourceIcon(this.icon, {
    this.isProduction = false,
    Key key,
  })
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isProduction
      ? _buildProductionIcon()
      : _buildQuantityIcon();
  }

  Widget _buildQuantityIcon() {
    return Icon(icon);
  }

  Widget _buildProductionIcon() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.brown,
      ),
      child: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }
}
