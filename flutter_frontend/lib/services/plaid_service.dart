import 'package:plaid_flutter/plaid_flutter.dart';
import 'dart:async';

class PlaidService {
  StreamSubscription<LinkSuccess>? _streamSuccess;
  StreamSubscription<LinkExit>? _streamExit;
  StreamSubscription<LinkEvent>? _streamEvent;

  void initialize({
    required void Function(String publicToken) onSuccess,
    required void Function(String message) onExit,
  }) {
    // 1. Listen to global streams provided by plaid_flutter
    _streamSuccess = PlaidLink.onSuccess.listen((success) {
      print('PLAID SUCCESS CALLBACK');
      print('publicToken: ${success.publicToken}');
      onSuccess(success.publicToken);
    });

    _streamExit = PlaidLink.onExit.listen((exit) {
      final message = exit.error?.message ?? 'User exited Plaid without completing flow';
      print('PLAID EXIT CALLBACK');
      print(message);
      onExit(message);
    });

    _streamEvent = PlaidLink.onEvent.listen((event) {
      print('PLAID EVENT: ${event.name}');
    });

    print('PlaidService initialized with success and exit callbacks.');
  }

  Future<void> openPlaidLink({required String linkToken}) async {
    // 2. Create the configuration token handler
    final configuration = LinkTokenConfiguration(
      token: linkToken,
    );
    
    // 3. Create the session first, then open
    await PlaidLink.create(configuration: configuration);
    PlaidLink.open();
  }

  void dispose() {
    // 4. Clean up subscriptions when done
    _streamSuccess?.cancel();
    _streamExit?.cancel();
    _streamEvent?.cancel();
  }
}

