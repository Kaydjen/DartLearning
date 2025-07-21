import 'dart:math';
import 'dart:io';

void main() {
  final random = Random();
  bool a = random.nextBool();
  if (!a) {
    print('You are gay');
  } else {
    print('You are straight');
  }
  String? asd = stdin.readLineSync();
  main();
}
