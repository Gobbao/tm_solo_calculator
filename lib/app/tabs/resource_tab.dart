import 'package:flutter/material.dart';

import '../app_state.dart';
import '../components/resource_card.dart';

class ResourceTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var state = AppState();

    return ListView(
      children: state.resources.keys
        .map((resourceKey) => ResourceCard(
          calculators: state.calculatorsGroupedByResource[resourceKey],
        ))
        .toList(),
    );
  }
}
