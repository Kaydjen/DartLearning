import 'dart:io';

import '../MainMenu.dart';

class OutputNegr {
    static void runNegra() {
      stdout.writeln("Please, enter something");
      String? input = stdin.readLineSync();
      print("Нигер");
      if (input == "") return; // just made it so vs code won't give me warning
      MainMenu.runWithDelay();
    }
    List<String> a = List.filled(2, "");
    static void run() {
        stdout.writeln("Please, enter a double value");
        double? input = double.tryParse(stdin.readLineSync()!);
        
        if (input != null)
          print("Your rounded value is = ${input.round()}");
        else
          print("You are invalid - you entered the wrong value");

        MainMenu.runWithDelay();
    }
}
