import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../app_state.dart';
import '../models/resources/resource.dart';
import 'resource_icon.dart';

class ResourceInput extends StatefulWidget {
  final Resource resource;
  final bool isProduction;

  ResourceInput(this.resource, {
    this.isProduction = false,
    Key key,
  })
    : super(key: key);

  @override
  _ResourceInputState createState() => _ResourceInputState();
}

class _ResourceInputState extends State<ResourceInput> {
  final TextEditingController _controller = TextEditingController();

  void _updateResource() {
    final int value = int.tryParse(_controller.text);
    final Resource resource = widget.resource;

    if (widget.isProduction) {
      resource.production = value;
      Provider.of<AppState>(context, listen: false).notifyUpdate();

      if (resource.production != value) {
        _controller.text = resource.production.toString();
      }

      return;
    }

    resource.quantity = value;
    Provider.of<AppState>(context, listen: false).notifyUpdate();

    if (resource.quantity != value) {
      _controller.text = resource.quantity.toString();
    }
  }

  String _getInitialValue() {
    return widget.isProduction
      ? widget.resource.production.toString()
      : widget.resource.quantity.toString();
  }

  void _selectAllText() {
    _controller.selection = TextSelection(
      baseOffset: 0,
      extentOffset: _controller.text.length,
    );
  }

  @override
  void initState() {
    super.initState();

    _controller
      ..text = _getInitialValue()
      ..addListener(_updateResource);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      onTap: _selectAllText,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        WhitelistingTextInputFormatter(RegExp(r'[0-9-]')),
      ],
      decoration: InputDecoration(
        icon: ResourceIcon(
          widget.resource.icon,
          isProduction: widget.isProduction,
        ),
      ),
    );
  }
}
