import 'package:flutter/material.dart';
import 'package:flutter_frontend/services/api_service.dart';
import 'package:flutter_frontend/services/plaid_service.dart';

import '../state/quickstart_provider.dart';
import 'plaid_link.dart';

class HeaderView extends StatelessWidget {
  const HeaderView({super.key});

  @override
  Widget build(BuildContext context) {
    final state = QuickstartProvider.of(context);
    final apiService = ApiService();
    // final plaidService = PlaidService(apiService: apiService);
    
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
              linkToken: 'demo-link-token-123',
            );
          },
          icon: const Icon(Icons.account_balance),
          label: const Text('Connect account'),
        ),
        FilledButton.icon(
          onPressed: () async {
            try {
              final data = await apiService.createLinkToken();
              final linkToken = data['link_token'] as String?;
              if (linkToken != null && linkToken.isNotEmpty) {
                state.update(
                  linkToken: linkToken, 
                  linkSuccess: true);
              }

              print('INFO: $data');
            } catch (e) {
              print('Info error: $e');
            }
          },
          icon: const Icon(Icons.token),
          label: const Text('createLinkToken'),
        ),
        PlaidLinkView(),
        // FilledButton.icon(
        //   onPressed: () async {
        //     try {
        //       await plaidService.openPlaidLink();
        //     } catch (e) {
        //       print('Link token error: $e');
        //     }
        //   },
        //   icon: const Icon(Icons.token),
        //   label: const Text('create link token'),
        // ),
      ],
    );
  }
}
