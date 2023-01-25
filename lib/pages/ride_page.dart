import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation_test/models/instruction.dart';
import 'package:navigation_test/models/ride.dart';

class RidePage extends StatelessWidget {
  RidePage({
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
        title: const Text('Ride'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(ride.id),
              ElevatedButton(
                onPressed: () {
                  context.go('/home/rides/ride/startRide?rideId=${ride.id}');
                },
                child: const Text('Start ride'),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: ride.instructions.length,
                  itemBuilder: (_, index) => ElevatedButton(
                    onPressed: () {
                      context.go(
                          '/home/rides/ride/instruction?rideId=${ride.id}&instructionId=${ride.instructions[index].id}' /*, extra: ride.instructions[index]*/);
                    },
                    child: Text('Instruction $index'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
