import 'dart:io';

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

}