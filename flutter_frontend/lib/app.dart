import 'package:flutter/material.dart';

import 'screens/header.dart';
import 'screens/quickstart_table.dart';

class App extends StatelessWidget {
	const App({super.key});

	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			theme: ThemeData(
				colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
				useMaterial3: true,
			),
			home: Scaffold(
				appBar: AppBar(title: const Text('appBar title "qs"')),
				body: const Padding(
					padding: EdgeInsets.all(24),
					child: Column(
						crossAxisAlignment: CrossAxisAlignment.stretch,
						children: [
							HeaderView(),
							SizedBox(height: 24),
							QuickstartTable(),
						],
					),
				),
			),
		);
	}
}
