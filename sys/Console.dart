import 'dart:io';
class Console{
  static void setConsoleSize(int height, int width) {
    // ANSI escape code to set terminal size (works in most Unix-like terminals)
    stdout.write('\x1B[8;${height};${width}t');
  }
  static void clear() => print('\x1B[2J\x1B[0;0H');
  static void defColor([bool doClear = true]) {
    print('\x1B[0m');
    if(doClear) clear();
  }  
  static void grayColor([bool doClear = true]) {
    print('\x1B[90m');
    if(doClear) clear();
  }  
  static void invalidInput([String errorMessage = "Please, enter proper input value ", String tipMessage = ""]){ // todo: polish of
        stdout.write("$errorMessage \nRestarting");
        for (var i = 0; i < 3; i++) {
          stdout.write('.');
          sleep(Duration(milliseconds: 750));
        }
  }
  static final int height = 31;
  static final int width = 75;
  static void placeCursor(int row, [int column = 0]){
    stdout.write('\x1B[${row};${column}H');
  }

}