import 'package:flutter/material.dart';
import 'package:navigation_test/models/instruction.dart';

class FinishInstructionPage extends StatelessWidget {
  FinishInstructionPage({
    Key? key,
    // required this.instruction,
    required this.rideId,
    required String instructionId,
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
        title: const Text('Finish instruction'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(instruction.id),
          ],
        ),
      ),
    );
  }
}
