import 'dart:io';

import '../00_hub_core/data/MenuMassages.dart';

class Console{
    static void setConsoleSize(int height, int width) {
        // ANSI escape code to set terminal size (works in most Unix-like terminals)
        stdout.write('\x1B[8;${height};${width}t');
    }
    static void clear() 
        => print('\x1B[2J\x1B[0;0H');
    static void defColor([bool doClear = true]) {
        print('\x1B[0m');
        if(doClear) clear();
    }  
    static void grayColor([bool doClear = true]) {
        print('\x1B[90m');
        if(doClear) clear();
    }  
    static String colorDefText() => "\u001b[38;5;255m";
    static String colorAdditTextReddish() => "\u001b[38;5;204m";
    static String colorDefInput() => "\u001b[38;5;196m";
    static String colorAdditInputWhitish() => "\u001b[38;5;252m";
    static String symbolColorDef(String symbol) => "${Console.colorDefInput()}$symbol${Console.colorDefText()}";
    static String symbolColorAddit(String symbol) => "${Console.colorAdditInputWhitish()}$symbol${Console.colorDefText()}";
    static void invalidInput({String errorMessage = "Please, enter proper input value ", String tipMessage = "",  int countOfLinesToClear = 3}){ // todo: polish of
          stdout.write("$errorMessage \nRestarting");
          for (var i = 0; i < 3; i++) {
              stdout.write('.');
              sleep(Duration(milliseconds: 750));
          }
          sleep(Duration(milliseconds: 100));
          clearPreviousLines(countOfLinesToClear);
    }
    static final int height = 31;
    static final int width = 75;
    static void placeCursor(int row, [int column = 0]) 
        => stdout.write('\x1B[${row};${column}H');
    

    static void clearPreviousLines(int count) {
        stdout.write('\x1B[2K');
        for (int i = 0; i < count-1; i++) {
            // Переместиться на строку вверх
            stdout.write('\x1B[1A');
            // Переместить курсор в начало строки
            stdout.write('\x1B[0G');
            // Очистить строку
            stdout.write('\x1B[2K');
        }
    }
    static void displayOptionsAndHandleChoice(Map<int, ChoosableOptions> options){
        Console.clear();
        String? message = "\nEnter option: ";
        for (var optionDescription in options.entries) 
        print("\u001b[38;5;196m${optionDescription.key}.\u001b[38;5;255m ${optionDescription.value.description}");
        //Console.defColor();
        while(true){
            final key = promptValidateIntDouble(message, countOfLinesToClear: 3).toInt();
            if(options.containsKey(key)) {
                options[key]!.onSelected!.call();            
                break;
            }
        }
    }
    static String promptValidate(String message, {int countOfLinesToClear = 3}){
        while (true) {
            String? input = prompt(message);
            if (input != null && input.trim().isNotEmpty) return input;            
            Console.invalidInput(countOfLinesToClear: countOfLinesToClear);
        }
    }
    static double promptValidateIntDouble(String message, {int countOfLinesToClear = 3, Function(String) onStringCheck = _func}){
        while (true) {
            final input = prompt(message);
            if (input != null && input.trim().isNotEmpty) {
                onStringCheck(input);
                final option = double.tryParse(input);
                if(option != null) return option;
            }           
            Console.invalidInput(countOfLinesToClear: countOfLinesToClear);
        }
    }

    static void _func(String input){
        
    }
    static String? prompt(String message) {
        stdout.write(message);
        stdout.write("\u001b[38;5;196m");
        final input = stdin.readLineSync()?.trim();
        stdout.write("\u001b[38;5;255m");
        return input;
    }
}