import 'package:flutter/material.dart';
import 'package:flutter_frontend/services/api_service.dart';
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
    
  }

  @override
  void dispose() {
    // Clean up the stream listeners when the widget is destroyed
    _plaidService.dispose();
    super.dispose();
  }
  // DEDICATED FUNCTION: Handles the backend call and state update
  // We pass the fresh state instance straight into it
  Future<void> _exchangePublicToken({
    required String publicToken, 
    required QuickstartState state,
    required ApiService apiService,
  }) async {
    print('Sending publicToken-- $publicToken to the backend server...');
    
    try {
      final data = await apiService.setAccessToken(publicToken);
      final accessToken = data['access_token'] as String?;
      
      if (accessToken != null && accessToken.isNotEmpty) {
        state.update(accessToken: accessToken);
        print('Access token set successfully: $accessToken');
      } else {
        print('Access token not found in backend response.');
      }
    } catch (e) {
      print('Error during backend token exchange: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = QuickstartProvider.of(context);
    final apiService = ApiService();

    return FilledButton.icon(
      onPressed: () async {
        try {
          // INITIALIZE LISTENERS: Set up dynamically inside onPressed
          _plaidService.initialize(
            onSuccess: (publicToken) {
              print('Success! Token received from Plaid: $publicToken');
              
              // CALL THE FUNCTION: Pass the token and the current active state
              _exchangePublicToken(
                publicToken: publicToken, 
                state: state,
                apiService: apiService,
              );
            },
            onExit: (message) {
              print('Exited: $message');
            },
          );

          // LAUNCH UI: Open the Plaid interface overlay
          await _plaidService.openPlaidLink(linkToken: state.linkToken ?? '');
          
        } catch (e) {
          print('Info error for plaidService: $e');
        }
      },
      icon: const Icon(Icons.token),
      label: const Text('Connect to Bank'),
    );
  }
}