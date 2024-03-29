import 'package:flutter/material.dart';

import '../models/calculators/calculator.dart';
import '../models/resources/resource.dart';
import 'calculator_table.dart';
import 'resource_input.dart';

class ResourceCard extends StatefulWidget {
  final Resource resource;
  final List<Calculator> calculators;

  ResourceCard({
    @required this.resource,
    @required this.calculators,
    Key key,
  }) : super(key: key);

  @override
  _ResourceCardState createState() => _ResourceCardState();
}

class _ResourceCardState extends State<ResourceCard> {
  @override
  Widget build(BuildContext context) {
    List<Calculator> calculators = widget.calculators;
    Resource resource = widget.resource;

    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('${resource.capitalizedName}:'),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(18.0, 0.0, 18.0, 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: ResourceInput(resource),
                    ),
                    Spacer(),
                    Expanded(
                      flex: 3,
                      child: ResourceInput(
                        resource,
                        isProduction: true,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.0),
                CalculatorTable(calculators),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
