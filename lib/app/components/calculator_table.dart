import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_state.dart';
import '../models/calculators/calculator.dart';
import 'decorated_table_cell.dart';

class CalculatorTable extends StatelessWidget {
  final List<Calculator> calculators;

  CalculatorTable(this.calculators);

  Widget _decorateMaximizeValue(Calculator calculator) {
    const TextStyle style = TextStyle(color: Colors.green);

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Text(
          '+${calculator.missingQuantity.abs()}',
          style: calculator.missingQuantity < 0 ? style : null,
        ),
        Text(' ('),
        Text(
          '+${calculator.missingProduction.abs()}',
          style: calculator.missingProduction < 0 ? style : null,
        ),
        Text(')'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Table(
      children: <TableRow>[
        TableRow(
          children: <Widget>[
            DecoratedTableCell(
              isHeader: true,
              child: Text('Convert to'),
            ),
            DecoratedTableCell(
              isHeader: true,
              isNumeric: true,
              child: Text('Cost'),
            ),
            DecoratedTableCell(
              isHeader: true,
              isNumeric: true,
              child: Text('To maximize'),
            ),
          ],
        ),
        ...calculators
          .map((calculator) => TableRow(
            children: <Widget>[
              DecoratedTableCell(
                child: Text(calculator.targetName)
              ),
              DecoratedTableCell(
                isNumeric: true,
                child: Text(calculator.conversionCost.toString()),
              ),
              DecoratedTableCell(
                isNumeric: true,
                child: Consumer<AppState>(
                  builder: (_, __, ___) => _decorateMaximizeValue(calculator),
                ),
              ),
            ],
          ))
          .toList(),
      ],
    );
  }
}
