import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/app.dart';
import 'app/app_state.dart';

void main() => runApp(ChangeNotifierProvider(
  create: (context) => AppState(),
  child: App(),
));
