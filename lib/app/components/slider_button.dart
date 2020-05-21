import 'package:flutter/material.dart';

class SliderButton extends StatelessWidget {
  final IconData icon;
  final Function onPressed;

  SliderButton({ this.icon, this.onPressed });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon),
      onPressed: onPressed,
    );
  }
}
