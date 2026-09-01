import 'package:flutter/material.dart';
import 'package:flutter_frontend/services/plaid_service.dart';
import '../state/quickstart_provider.dart';


class PlaidLinkView extends StatefulWidget {
  const PlaidLinkView({super.key});

  @override
  State<PlaidLinkView> createState() => _PlaidLinkViewState();
}

class _PlaidLinkViewState extends State<PlaidLinkView> {
  late final PlaidService _plaidService;

  @override
  void initState() {
    super.initState();
    _plaidService = PlaidService();
    
    // 1. Initialize the listeners when the widget enters the tree
    _plaidService.initialize(
      onSuccess: (publicToken) {
        print('Success! Token: $publicToken');
        // TODO: Send publicToken to your backend
      },
      onExit: (message) {
        print('Exited: $message');
      },
    );
  }

  @override
  void dispose() {
    // 2. Clean up the stream listeners when the widget is destroyed
    _plaidService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = QuickstartProvider.of(context);
    
    return FilledButton.icon(
      onPressed: () async {
        try {
          await _plaidService.openPlaidLink(
            linkToken: state.linkToken ?? '',
          );
        } catch (e) {
          print('Info error for plaidService: $e');
        }
      },
      icon: const Icon(Icons.token),
      label: const Text('PlaidLinkView - createLinkToken'),
    );
  }
}