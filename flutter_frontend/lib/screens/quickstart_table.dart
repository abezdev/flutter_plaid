import 'package:flutter/material.dart';

import '../state/quickstart_provider.dart';

class QuickstartTable extends StatelessWidget {
  const QuickstartTable({super.key});

  @override
  Widget build(BuildContext context) {
    final state = QuickstartProvider.of(context);

    return Card(
      child: DataTable(
        columns: const [
          DataColumn(label: Text('Value')),
          DataColumn(label: Text('Current state')),
        ],
        rows: [
          DataRow(
            cells: [
              const DataCell(Text('linkSuccess')),
              DataCell(Text(state.linkSuccess.toString())),
            ],
          ),
          DataRow(
            cells: [
              const DataCell(Text('itemId')),
              DataCell(Text(state.itemId ?? 'Not connected')),
            ],
          ),
          DataRow(
            cells: [
              const DataCell(Text('accessToken')),
              DataCell(Text(state.accessToken ?? 'Not available')),
            ],
          ),
        ],
      ),
    );
  }
}
