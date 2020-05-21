import 'package:flutter/material.dart';

import '../models/parameter.dart';
import 'slider_button.dart';

class ParameterCard extends StatefulWidget {
  final Parameter parameter;

  ParameterCard({ Key key, this.parameter }) : super(key: key);

  @override
  _ParameterCardState createState() => _ParameterCardState();
}

class _ParameterCardState extends State<ParameterCard> {
  void _updateLevel(double level) {
    setState(() {
      widget.parameter.currentLevel = level.toInt();
    });
  }

  void _decrementLevel() {
    setState(() {
      widget.parameter.decrementLevel();
    });
  }

  void _incrementLevel() {
    setState(() {
      widget.parameter.incrementLevel();
    });
  }

  @override
  Widget build(BuildContext context) {
    Parameter parameter = widget.parameter;

    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.people),
            title: Text('${parameter.capitalizedName}:'),
            trailing: Text('${parameter.formatedCurrentLevel}'),
          ),
          Row(
            children: <Widget>[
              SliderButton(
                icon: Icons.remove,
                onPressed: parameter.isFirstLevel ? null : _decrementLevel,
              ),
              Expanded(
                child: Slider(
                  value: parameter.currentLevel.toDouble(),
                  min: parameter.initialLevel.toDouble(),
                  max: parameter.finalLevel.toDouble(),
                  divisions: parameter.totalLevels,
                  label: '${parameter.formatedCurrentLevel}',
                  onChanged: _updateLevel,
                  onChangeEnd: (_) {},
                ),
              ),
              SliderButton(
                icon: Icons.add,
                onPressed: parameter.isLastLevel ? null : _incrementLevel,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
