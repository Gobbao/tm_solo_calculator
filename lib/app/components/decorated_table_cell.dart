import 'package:flutter/material.dart';

class DecoratedTableCell extends StatelessWidget {
  final bool isHeader;
  final AlignmentGeometry alignment;
  final Widget child;

  DecoratedTableCell({
    @required this.child,
    this.isHeader = false,
    bool isNumeric = false,
    Key key,
  })
    : alignment = isNumeric ? Alignment.centerRight : Alignment.centerLeft,
      super(key: key);

  BoxDecoration _buildBorder(BuildContext context) {
    if (!isHeader) return null;

    return BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: Theme.of(context).dividerColor,
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _buildBorder(context),
      padding: EdgeInsets.symmetric(vertical: isHeader ? 0.0 : 5.0),
      child: Align(
        alignment: alignment,
        child: child,
      ),
    );
  }
}
