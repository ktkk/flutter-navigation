import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:navigation_test/models/instruction.dart';
import 'package:navigation_test/models/ride.dart';

import 'package:navigation_test/services/authentication_service.dart';

import 'package:navigation_test/pages/finish_instruction_page.dart';
import 'package:navigation_test/pages/home_page.dart';
import 'package:navigation_test/pages/instruction_page.dart';
import 'package:navigation_test/pages/login_page.dart';
import 'package:navigation_test/pages/ride_page.dart';
import 'package:navigation_test/pages/rides_page.dart';
import 'package:navigation_test/pages/start_ride_page.dart';

/*
* Navigation layout:
*
* /
* /login
* /home
*   rides
*     ride
*       startRide
*       instruction
*
*/

final router = GoRouter(
  debugLogDiagnostics: true,
  redirect: (context, state) async {
    final bool isLoggedIn =
        await AuthenticationServiceScope.of(context).isSignedIn();
    final bool isLoggingIn = state.subloc == '/login';

    // debugPrint('Is logged in: $isLoggedIn. Is logging in: $isLoggingIn');

    // If the user is not logged in, the 'Login' page should be displayed.
    if (!isLoggedIn) {
      return '/login';
    }

    // If the user is on the 'Login' page but we passed the login check,
    // the user should be directed to the "Home" screen.
    if (isLoggingIn) {
      return '/home';
    }

    // In all other cases, we should stay on the 'Loading' page.
    return null;
  },
  routes: [
    /// This should never be visible, as 'redirect' should navigate to 'Login' instead.
    /// Is it still necessary then?
    GoRoute(
      path: '/',
      builder: (_, state) => Container(
        color: Colors.red,
      ),
    ),
    GoRoute(
      path: '/login',
      builder: (_, state) => const LoginPage(),
    ),
    /// The Home page. In the future this will have more submodules besides 'Rides'.
    GoRoute(
      path: '/home',
      builder: (_, state) => const HomePage(),
      routes: [
        GoRoute(
          path: 'rides',
          builder: (_, state) => const RidesPage(),
          routes: [
            /// Ride page. Passing the [rideId] here makes sense.
            /// Apparently you can pass models directly, but this proved cumbersome
            /// for navigating back. Also not sure about performance (felt slower).
            GoRoute(
              path: 'ride',
              builder: (_, state) => RidePage(
                // ride: state.extra! as Ride,
                rideId: state.queryParams['rideId']!,
              ),
              /// Start ride page. Passing [rideId] still makes sense here.
              routes: [
                GoRoute(
                  path: 'startRide',
                  builder: (_, state) => StartRidePage(
                    // ride: state.extra! as Ride,
                    rideId: state.queryParams['rideId']!,
                  ),
                ),
                /// Instruction page. Passing [instructionId] here makes sense.
                /// However, I am unsure why I need to pass [rideId] here.
                /// If I don't pass it, I get trouble navigation back to the 'Ride' page
                GoRoute(
                  path: 'instruction',
                  builder: (_, state) => InstructionPage(
                    // instruction: state.extra! as Instruction,
                    rideId: state.queryParams['rideId']!,
                    instructionId: state.queryParams['instructionId']!,
                  ),
                  routes: [
                    /// Finish instruction page. Again, passing [instructionId] makes sense,
                    /// but having to pass [rideId] at this point just gets annoying.
                    GoRoute(
                      path: 'finishInstruction',
                      builder: (_, state) => FinishInstructionPage(
                        // instruction: state.extra! as Instruction,
                        rideId: state.queryParams['rideId']!,
                        instructionId: state.queryParams['instructionId']!,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
