import 'dart:io';
class Console{
    void console(){
        print("\x1B[2J\x1B[0;0H");  //Очистить консоль
        sleep(Duration(seconds: 2)); //Отладка в синк
        //await Future.delayed(Duration(seconds: 1));  //Отладка в асинк
        stdout.write('\x1B[1A'); //Переместиться на строку вверх
        stdout.write('\x1B[0G'); //Переместить курсор в начало строки
    }
}