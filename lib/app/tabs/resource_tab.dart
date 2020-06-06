import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_state.dart';
import '../components/resource_card.dart';

class ResourceTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AppState>(context, listen: false);

    return ListView(
      children: state.resources.keys
        .map((resourceKey) => ResourceCard(
          resource: state.resources[resourceKey],
          calculators: state.calculatorsGroupedByResource[resourceKey],
        ))
        .toList(),
    );
  }
}
