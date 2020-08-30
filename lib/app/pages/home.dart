import 'package:flutter/material.dart';

import '../components/tabs/parameter_tab.dart';
import '../components/tabs/resource_tab.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: <Widget>[
              Tab(text: 'PARAMETERS'),
              Tab(text: 'RESOURCES'),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            ParameterTab(),
            ResourceTab(),
          ],
        ),
      ),
    );
  }
}
