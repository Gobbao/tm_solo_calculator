import 'package:flutter/material.dart';

import 'pages/home.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TM Solo Calculator',
      home: HomePage(),
    );
  }
}
