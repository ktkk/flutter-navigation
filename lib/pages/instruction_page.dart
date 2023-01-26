import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation_test/models/instruction.dart';

class InstructionPage extends StatelessWidget {
  InstructionPage({
    Key? key,
    // required this.instruction,
    required String instructionId,
    required this.rideId,
  }) : super(key: key) {
    instruction = Instruction(
      id: instructionId,
    );
  }

  final String rideId;
  late final Instruction instruction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Instruction'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(instruction.id),
            ElevatedButton(
              onPressed: () {
                context.pushNamed(
                  'finishInstruction',
                  params: {
                    'rideId': rideId,
                    'instructionId': instruction.id,
                  },
                );
              },
              child: const Text('Finish instruction'),
            ),
          ],
        ),
      ),
    );
  }
}
