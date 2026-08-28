import 'package:flutter/material.dart';

class QuickstartState extends ChangeNotifier {
  bool linkSuccess = false;
  String? accessToken;
  String? itemId;

  void update({bool? linkSuccess, String? accessToken, String? itemId}) {
    this.linkSuccess = linkSuccess ?? this.linkSuccess;
    this.accessToken = accessToken ?? this.accessToken;
    this.itemId = itemId ?? this.itemId;
    notifyListeners();
  }
}

class QuickstartProvider extends InheritedNotifier<QuickstartState> {
  const QuickstartProvider({
    super.key,
    required QuickstartState notifier,
    required super.child,
  }) : super(notifier: notifier);

  static QuickstartState of(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<QuickstartProvider>();
    assert(provider != null, 'QuickstartProvider is missing above this widget.');
    return provider!.notifier!;
  }
}