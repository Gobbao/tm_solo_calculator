import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_state.dart';
import '../components/parameter_card.dart';

class ParameterTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AppState>(context, listen: false);

    return ListView(
      children: state.parameters
        .map((parameter) => ParameterCard(parameter: parameter))
        .toList(),
    );
  }
}
