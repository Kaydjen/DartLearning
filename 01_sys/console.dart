import 'dart:io';

class Console{
    static const int heightInit = 31;
    static const int widthInit = 75;
    static int _height = heightInit;
    static int _width = heightInit;

    static int get height => _height;
    static int get width => _width;

    static void setConsoleSize({int? height, int? width = widthInit}) {
        height ??= _height;
        width ??= _width;
        stdout.write('\x1B[8;${height};${width}t');
        _height = height;
        _width = width;
    }
    static void placeCursor(int row, [int column = 0]) => stdout.write('\x1B[${row};${column}H');

    static void clear() => print('\x1B[2J\x1B[0;0H');
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