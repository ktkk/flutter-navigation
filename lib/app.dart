import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation_test/pages/settings_page.dart';

import 'package:navigation_test/services/authentication_service.dart';

import 'package:navigation_test/pages/finish_instruction_page.dart';
import 'package:navigation_test/pages/home_page.dart';
import 'package:navigation_test/pages/instruction_page.dart';
import 'package:navigation_test/pages/login_page.dart';
import 'package:navigation_test/pages/ride_page.dart';
import 'package:navigation_test/pages/rides_page.dart';
import 'package:navigation_test/pages/start_ride_page.dart';

class SitraDriversApp extends StatelessWidget {
  SitraDriversApp({Key? key}) : super(key: key);

  final _scaffoldKey = const ValueKey<String>('App scaffold');

  final _auth = AuthenticationService();

  String? _guard(BuildContext context, GoRouterState state) {
    final bool signedIn = _auth.signedIn;
    final bool signingIn = state.subloc == '/login';

    if (!signedIn && !signingIn) {
      return '/login';
    } else if (signedIn && signingIn) {
      return '/home';
    }

    return null;
  }

  late final _router = GoRouter(
    debugLogDiagnostics: true,
    redirect: _guard,
    refreshListenable: _auth,
    routes: [
      GoRoute(path: '/', redirect: (_, __) => '/home'),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (_, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (_, state) => const SettingsPage(),
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (_, state) => const HomePage(),
        routes: [
          GoRoute(
            path: 'rides',
            name: 'rides',
            builder: (_, state) => const RidesPage(),
            routes: [
              GoRoute(
                path: 'ride/:rideId',
                name: 'ride',
                builder: (_, state) => RidePage(
                  rideId: state.params['rideId']!,
                ),
                routes: [
                  GoRoute(
                    path: 'instruction/:instructionId',
                    name: 'instruction',
                    builder: (_, state) => InstructionPage(
                      rideId: state.params['rideId']!,
                      instructionId: state.params['instructionId']!,
                    ),
                    routes: [
                      GoRoute(
                        path: 'finishInstruction',
                        name: 'finishInstruction',
                        builder: (_, state) => FinishInstructionPage(
                          rideId: state.params['rideId']!,
                          instructionId: state.params['instructionId']!,
                        ),
                      ),
                    ],
                  ),
                  GoRoute(
                    path: 'startRide',
                    name: 'startRide',
                    builder: (_, state) => StartRidePage(
                      rideId: state.params['rideId']!,
                    ),
                  ),
                ],
              ),
            ],
          ),
          GoRoute(
            path: 'messaging',
            name: 'messaging',
            builder: (_, __) => Container(),
          ),
          GoRoute(
            path: 'damageCheck',
            name: 'damageCheck',
            builder: (_, __) => Container(),
          ),
          GoRoute(
            path: 'documents',
            name: 'documents',
            builder: (_, __) => Container(),
          ),
          GoRoute(
            path: 'manualsMovies',
            name: 'manualsMovies',
            builder: (_, __) => Container(),
          ),
        ],
      ),
      // GoRoute(
      //   path: '/ride/:rideId',
      //   redirect: (_, state) => '/rides/${state.params['rideId']!}',
      //   routes: [
      //     GoRoute(
      //       path: ':instructionId',
      //       redirect: (_, state) =>
      //           '/rides/${state.params['rideId']!}/${state.params['instructionId']!}',
      //     ),
      //   ],
      // ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return AuthenticationServiceScope(
      notifier: _auth,
      child: MaterialApp.router(
        routerConfig: _router,
      ),
    );
  }
}
