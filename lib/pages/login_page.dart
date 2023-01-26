import 'package:flutter/material.dart';
import 'package:navigation_test/services/authentication_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  bool isLoggingIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoggingIn)
              const CircularProgressIndicator()
            else
              ElevatedButton(
                  onPressed: () {
                    AuthenticationServiceScope.of(context).signIn();
                    setState(() {
                      isLoggingIn = true;
                    });
                  },
                  child: const Text('Login'),
              ),
          ],
        ),
      ),
    );
  }
}
