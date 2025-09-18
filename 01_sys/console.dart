import 'dart:io';

class Console{
    static final int height = 31;
    static final int width = 75;

    static void setConsoleSize(int height, int width) => stdout.write('\x1B[8;${height};${width}t');
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