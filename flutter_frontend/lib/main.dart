import 'app.dart';
import 'state/quickstart_provider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    QuickstartProvider(
      notifier: QuickstartState(),
      child: const App(),
    ),
  );
}
