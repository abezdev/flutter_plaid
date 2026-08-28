import 'package:flutter/material.dart';

import '../state/quickstart_provider.dart';

class HeaderView extends StatelessWidget {
  const HeaderView({super.key});

  @override
  Widget build(BuildContext context) {
    final state = QuickstartProvider.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Expanded(
          child: Text(
            'Plaid Quickstart',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        FilledButton.icon(
          onPressed: () {
            state.update(
              linkSuccess: true,
              itemId: 'demo-item-123',
            );
          },
          icon: const Icon(Icons.account_balance),
          label: const Text('Connect account'),
        ),
      ],
    );
  }
}
