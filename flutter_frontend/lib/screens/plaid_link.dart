import 'package:flutter/material.dart';
import 'package:flutter_frontend/services/plaid_service.dart';
import '../state/quickstart_provider.dart';



class PlaidLinkView extends StatelessWidget {
  const PlaidLinkView({super.key});

  @override
  Widget build(BuildContext context) {
    final state = QuickstartProvider.of(context);
    final plaidService = PlaidService();
    
    return FilledButton.icon(
          onPressed: () async {
            try {
              await plaidService.openPlaidLink(
                linkToken: state.linkToken ?? '',
                // onSuccess: (publicToken, metadata) {
                //   print('Plaid Link Success: $publicToken, $metadata');
                //   state.update(linkSuccess: true);
                // },
                // onExit: (error, metadata) {
                //   print('Plaid Link Exit: $error, $metadata');
                //   state.update(linkSuccess: false);
                // },
              );

              // final data = await apiService.createLinkToken();
              // final linkToken = data['link_token'] as String?;
              // if (linkToken != null && linkToken.isNotEmpty) {
              //   state.update(
              //     linkToken: linkToken, 
              //     linkSuccess: true);
              // }
              
              // print('INFO: $data');
            } catch (e) {
              print('Info error for plaidService: $e');
            }
          },
          icon: const Icon(Icons.token),
          label: const Text('PlaidLinkView - createLinkToken'),
        );
  }
}


