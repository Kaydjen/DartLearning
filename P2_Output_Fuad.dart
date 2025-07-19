import 'dart:io';

/*
2. Ввод в консоль
   - Задание: 
      1. На любой ввод ответ - "Негр"
      2. высчитывание процентов
     Теория:
          - stdin.readLineSync()
          - Парсинг введенных данных
     Практические задания:
          Уровень 1 (Базовый)
               1. На любой ввод ответ - "Негр":
                    (Да, даже если ввели число или пустую строку.)
               2. Запросите у пользователя дробное число (например, 3.14) и выведите его, округлив до целого:
                    Введите число: 3.14  
                    Округленное: 3  
*/

void Fuad() {
  String? input = stdin.readLineSync();
  print('негр');
}

void Krugloe() {
  String? input = stdin.readLineSync();
  if (input == null) {
    print('No input was provided');
    return;
  }

  double? integral = double.tryParse(input);
  if (integral == null) {
    print('invalid number');
    return;
  }
  int number = integral.round();
  print(number);
}
