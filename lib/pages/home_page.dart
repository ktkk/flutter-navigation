import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation_test/services/authentication_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authenticationService = AuthenticationServiceScope.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                authenticationService.signOut();
              },
              child: const Text('Logout'),
            ),
            ElevatedButton(
              onPressed: () {
                context.go('/home/rides');
              },
              child: const Text('Rides'),
            )
          ],
        ),
      ),
    );
  }
}
