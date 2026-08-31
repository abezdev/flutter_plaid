import 'package:plaid_flutter/plaid_flutter.dart';

// import 'api_service.dart';

class PlaidService {
  // PlaidService({required this.apiService});

  // final ApiService apiService;

  Future<void> openPlaidLink({required String linkToken}) async {
    // final data = await apiService.createLinkToken();
    // final linkToken = data['link_token'] as String?;

    if ( linkToken.isEmpty) { //linkToken == null ||
      throw Exception('No link_token returned from backend');
    }

    
  
    // PlaidLink.open(
    //   configuration: LinkTokenConfiguration(
    //     token: linkToken,
    //   ),
    //   onSuccess: (success) {
    //     print('Plaid success: ${success.publicToken}');
    //   },
    //   onExit: (exit) {
    //     print('Plaid exit: ${exit.error?.message ?? 'User exited'}');
    //   },
    //   onEvent: (event) {
    //     print('Plaid event: ${event.name}');
    //   },
    // );


    // 1. Set up your configuration
    LinkTokenConfiguration configuration = LinkTokenConfiguration(
      token: linkToken,
    );

    // 2. Initialize Plaid Link first
    await PlaidLink.create(configuration: configuration);

    // 3. Open it separately
    await PlaidLink.open();
  }
}
