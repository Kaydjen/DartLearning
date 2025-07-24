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
}