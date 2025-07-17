import 'dart:io';

class Outputnegr {
  static void RunNegra() {
    String? input = stdin.readLineSync();
    print("Нигер");
    if (input == "") return; // just made it so vs code won't give me warning
  }

  static void Run() {
    stdout.writeln("Please, enter a double value");
    double? input = double.tryParse(stdin.readLineSync()!);

    if (input != null)
      print("Your rounded value is = ${input.round()}");
    else
      print("You are invalid - you entered the wrong value");
  }
}
