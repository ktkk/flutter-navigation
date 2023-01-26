import 'package:flutter/material.dart';
import 'package:navigation_test/models/instruction.dart';
import 'package:navigation_test/models/ride.dart';

class StartRidePage extends StatelessWidget {
  StartRidePage({
    Key? key,
    // required this.ride,
    required String rideId,
  }) : super(key: key) {
    ride = Ride(
      id: rideId,
      instructions: List.generate(
        4,
        (index) => Instruction(
          id: 'instruction_$index',
        ),
      ),
    );
  }

  late final Ride ride;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Start ride'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(ride.id),
          ],
        ),
      ),
    );
  }
}
