import 'dart:math';
import 'dart:io';

void minus(List<String> args) {
  for (int x = 1000; x >= 0; x -= 7) {
    print(Sigil(x));
  }
}

int Sigil(int nomer) {
  int x = nomer * 2;
  return x;
}

void gay() {
  final random = Random();
  bool a = random.nextBool();
  if (!a) {
    print('You are gay');
  } else {
    print('You are straight');
  }
  String? asd = stdin.readLineSync();
  gay();
}
