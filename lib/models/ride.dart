import 'package:navigation_test/models/instruction.dart';

class Ride {
  const Ride({
    required this.id,
    required this.instructions,
  });

  final String id;
  final List<Instruction> instructions;
}
