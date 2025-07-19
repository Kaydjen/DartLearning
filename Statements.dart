/*3. Условия
   - if-else, switch-case
   - Тернарный оператор
   - Задание: 
      1. Выполнение функции в зависимости от чётности/нечётности
      2. Числа от 1-го до 26-соотвестуют букве из алфавита */
import 'dart:io';

class Statements {
  static void Run() {
    int? nr = int.tryParse(stdin.readLineSync()!);
    if ((nr != null) && (nr % 2 == 0)) {
      print('Your number is even');
    } else {
      print('Your number is odd');
    }
  }
}

class Stats {
  static void Run() {
    int? nr = int.tryParse(stdin.readLineSync()!);
    if ((nr != null) && (nr >= 1) && (nr <= 26)) {
      String letter = String.fromCharCode((nr + 64));
      print('Your letter is $letter');
    } else {
      print('Your number is out of range (1-26)');
    }
  }
}
