import 'dart:async';

import 'package:flutter/cupertino.dart';

/// Mock authentication service.
/// Based on the [StreamAuth] from the go_router example
class AuthenticationService {
  AuthenticationService(/*{
    this.refreshInterval = 20,
  }*/) : _userStreamController = StreamController<String?>.broadcast() {
    _userStreamController.stream.listen((String? currentUser) {
      _currentUser = currentUser;
    });
  }

  // final int refreshInterval;
  // Timer? _timer;

  String? get currentUser => _currentUser;
  String? _currentUser;

  Stream<String?> get onCurrentUserChanged => _userStreamController.stream;
  final StreamController<String?> _userStreamController;

  // Timer _createRefreshTimer() {
  //   return Timer(Duration(seconds: refreshInterval), () {
  //     _userStreamController.add(null);
  //     _timer = null;
  //   });
  // }

  Future<bool> isSignedIn() async {
    await Future<void>.delayed(const Duration(seconds: 1));

    return _currentUser != null;
  }

  Future<void> signIn(String newUserName) async {
    await Future<void>.delayed(const Duration(seconds: 1));

    _userStreamController.add(newUserName);
    // _timer?.cancel();
    // _timer = _createRefreshTimer();
  }

  Future<void> signOut() async {
    // _timer?.cancel();
    // _timer = null;
    _userStreamController.add(null);
  }
}

class AuthenticationServiceNotifier extends ChangeNotifier {
  AuthenticationServiceNotifier()
      : authenticationService = AuthenticationService() {
    authenticationService.onCurrentUserChanged.listen((String? string) {
      notifyListeners();
    });
  }

  final AuthenticationService authenticationService;
}

class AuthenticationServiceScope
    extends InheritedNotifier<AuthenticationServiceNotifier> {
  AuthenticationServiceScope({
    Key? key,
    required Widget child,
  }) : super(
          key: key,
          notifier: AuthenticationServiceNotifier(),
          child: child,
        );

  static AuthenticationService of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<AuthenticationServiceScope>()!
      .notifier!
      .authenticationService;
}
