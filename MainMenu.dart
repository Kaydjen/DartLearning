import 'dart:io';
import 'data/MenuMassages.dart';
import 'sys/Console.dart';

class MainMenu {
    static void run(){
        Console.grayColor();
        stdin.echoMode = false; // Disable echoing typed characters
        for (var el in MenuMessages.firstMenuOptions.keys) 
            print("${el}. ${MenuMessages.firstMenuOptions[el]!.description} ");

        int? input = int.tryParse(stdin.readLineSync()!);
        if(MenuMessages.firstMenuOptions.containsKey(input))
        {
            stdin.echoMode = true; 
            MenuMessages.firstMenuOptions[input]?.onSelected?.call();
        }
        else _invalidInput();

        stdin.echoMode = true; 
    }
    static void runWithDelay(){
        sleep(Duration(seconds: 1));
        run();
    }
    static void _invalidInput(){
        Console.defColor(false);
        stdout.write("Please, choose the right option \nRestarting");
        for (var i = 0; i < 3; i++) {
          stdout.write('.');
          sleep(Duration(milliseconds: 750));
        }
        run();
    }
}