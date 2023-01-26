import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation_test/models/instruction.dart';
import 'package:navigation_test/models/ride.dart';

class RidesPage extends StatelessWidget {
  const RidesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Ride> rides = List.generate(
      10,
      (index) => Ride(
        id: 'ride_$index',
        instructions: List.generate(
          4,
          (index) => Instruction(
            id: 'ride_$index',
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rides'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: rides.length,
            itemBuilder: (_, index) => ElevatedButton(
              onPressed: () {
                context.pushNamed(
                  'ride',
                  params: {
                    'rideId': rides[index].id,
                  }, /*, extra: rides[index]*/
                );
              },
              child: Text('Ride $index'),
            ),
          ),
        ),
      ),
    );
  }
}
