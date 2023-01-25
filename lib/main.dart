import 'package:flutter/material.dart';
import 'package:navigation_test/router.dart';
import 'package:navigation_test/services/authentication_service.dart';

void main() => runApp(
      AuthenticationServiceScope(
        child: const MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Navigation test',
      routerConfig: router,
    );
  }
}
