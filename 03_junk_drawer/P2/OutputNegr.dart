import 'dart:io';
import '../../00_hub_core/menu_system/Menu.dart';

class OutputNegr {
    static void runNegra() {
      stdout.writeln("Please, enter something");
      String? input = stdin.readLineSync();
      print("Нигер");
      if (input == "") return; // just made it so vs code won't give me warning

      Menu.runMenuWithDelay(menuTypes.junk_drawer, 2000);
    }
    List<String> a = List.filled(2, "");
    static void run() {
        stdout.writeln("Please, enter a double value");
        double? input = double.tryParse(stdin.readLineSync()!);
        
        if (input != null)
          print("Your rounded value is = ${input.round()}");
        else
          print("You are invalid - you entered the wrong value");
     
        Menu.runMenuWithDelay(menuTypes.junk_drawer, 2000);
    }
}
