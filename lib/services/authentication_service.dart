import 'dart:async';

import 'package:flutter/cupertino.dart';

/// Mock authentication service.
/// Based on the [StreamAuth] from the go_router example
class AuthenticationService extends ChangeNotifier {
  bool _signedIn = false;
  bool get signedIn => _signedIn;

  Future<bool> signIn() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));

    _signedIn = true;
    notifyListeners();

    return _signedIn;
  }

  Future<void> signOut() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));

    _signedIn = false;
    notifyListeners();
  }
}

class AuthenticationServiceScope
    extends InheritedNotifier<AuthenticationService> {
  const AuthenticationServiceScope({
    Key? key,
    required AuthenticationService notifier,
    required Widget child,
  }) : super(
          key: key,
          notifier: notifier,
          child: child,
        );

  static AuthenticationService of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<AuthenticationServiceScope>()!
      .notifier!;
}
