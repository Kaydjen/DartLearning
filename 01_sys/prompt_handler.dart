import 'dart:io';
import 'dart:convert';
import 'color.dart';
import 'console.dart';

class Prompt {
    /// It prints one single line in the middle of current console line
    static void printOneLn(String message){
        int rows = ((Console.width - message.length)/2).round();
        Console.placeCursor(rows);
        print(message);
    }
    static void invalidInput({String errorMessage = "Please, enter proper input value ", String tipMessage = "",  int countOfLinesToClear = 3}){ // todo: polish of
        stdout.write(Color.set(ColorTypes.red, str: "$errorMessage ${Color.grayWhite()}\nRestarting"));
        for (var i = 0; i < 3; i++) {
            stdout.write('${Color.grayWhite()}.');
            sleep(Duration(milliseconds: 750));
        }
        sleep(Duration(milliseconds: 100));
        Console.clearPreviousLines(countOfLinesToClear);
    }
    static String validate(String message, {int countOfLinesToClear = 3, Function(String) onStringCheck = _func}){
        while (true) {
            String? input = prompt(message);
            if (input != null && input.isNotEmpty) {
                onStringCheck(input);
                return input;
            }            
            invalidInput(countOfLinesToClear: countOfLinesToClear);
        }
    }
    static double validateIntDouble(String message, {int countOfLinesToClear = 3, Function(String) onStringCheck = _func}){
        while (true) {
            final input = prompt(message);
            if (input != null && input.isNotEmpty) {
                onStringCheck(input);
                final option = double.tryParse(input);
                if(option != null) return option;
            }           
            invalidInput(countOfLinesToClear: countOfLinesToClear);
        }
    }

    static void _func(String input){
        
    }
    static String? prompt(String message) {
        stdout.write(message);
        stdout.write("\u001b[38;5;196m");
        final input = stdin.readLineSync(encoding: utf8)?.trim();
        stdout.write("\u001b[38;5;255m");
        return input;
    }
}