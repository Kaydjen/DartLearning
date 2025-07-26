import 'dart:io';

import '../menu_system/Menu.dart';


class Statements {
    static void runOddEven() {
        bool doReturn = true;
        int countOfReturns = 0;

        while(doReturn){
            stdout.writeln("Please, enter your value");
            int? input = int.tryParse(stdin.readLineSync()!);
            if (input == null) {
                if(countOfReturns == 1) print("Invalid, your input mast be NUMBER, and not that shit you've entered before");
                else print("Invalid input, pomieniaj bliat");
                countOfReturns++;
                continue;
            }
            if (input % 2 == 0)
                print("Your number is even");
            else
                print("Your number is odd");
            doReturn = false;
        }
        Menu.runMenuWithDelay(menuTypes.secondary, 2000);
    }
    static void run() {
        stdout.writeln("Please, enter your value");
        int? input = int.tryParse(stdin.readLineSync()!);
        if (input == null) {
            print("Invalid input, pomieniaj bliat");
            runOddEven();
            return;
        }

        if(true){
            print("XUI");
        }
        Menu.runMenuWithDelay(menuTypes.secondary, 2000);
    }
}
