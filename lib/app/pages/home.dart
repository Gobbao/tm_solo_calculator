import 'package:flutter/material.dart';
import 'package:tm_solo_calculator/app/tabs/parameter_tab.dart';
import 'package:tm_solo_calculator/app/tabs/resource_tab.dart';

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
