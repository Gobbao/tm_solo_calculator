import 'package:flutter/material.dart';

import '../app_state.dart';
import '../components/parameter_card.dart';

class ParameterTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var state = AppState();

    return ListView(
      children: List.from([state.generation])
        .followedBy(state.parameters.values)
        .map((parameter) => ParameterCard(parameter: parameter)).toList(),
    );
  }
}
