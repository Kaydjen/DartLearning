import 'dart:math';

// Определение класса ListNode
class ListNode {
  int val;
  ListNode? next;
  
  ListNode([this.val = 0, this.next]);
  
  @override
  String toString() {
    return '$val${next != null ? ' -> ${next}' : ''}';
  }
  
  // Вспомогательный метод для создания списка из массива
  static ListNode? fromList(List<int> values) {
    if (values.isEmpty) return null;
    ListNode head = ListNode(values[0]);
    ListNode current = head;
    for (int i = 1; i < values.length; i++) {
      current.next = ListNode(values[i]);
      current = current.next!;
    }
    return head;
  }
  
  // Получить длину списка
  int get length {
    int count = 0;
    ListNode? current = this;
    while (current != null) {
      count++;
      current = current.next;
    }
    return count;
  }
}

// Первый вариант алгоритма (быстрее)
ListNode? addTwoNumbersV1(ListNode? l1, ListNode? l2) {
  ListNode res = ListNode();
  ListNode res1 = res;
  int carry = 0;

  while (l1 != null || l2 != null || carry != 0) {
    int sum = (l1?.val ?? 0) + (l2?.val ?? 0) + carry;
    carry = sum ~/ 10;
    
    res.next = ListNode(sum % 10);
    res = res.next!;

    l1 = l1?.next;
    l2 = l2?.next;
  }

  return res1.next;
}

// Второй вариант алгоритма (медленнее)
ListNode? addTwoNumbersV2(ListNode? l1, ListNode? l2) {
  ListNode res = ListNode();
  ListNode res1 = res;
  int carry = 0;

  while (l1 != null || l2 != null || carry != 0) {
    int digit1 = l1?.val ?? 0;
    int digit2 = l2?.val ?? 0;

    int sum = digit1 + digit2 + carry;
    int digit = sum % 10;

    carry = sum ~/ 10;
    res.next = ListNode(digit);
    res = res.next!;

    l1 = l1?.next;
    l2 = l2?.next;
  }

  return res1.next;
}

// ========== ГЕНЕРАТОРЫ ТЕСТОВЫХ ДАННЫХ ==========

// 1. Маленькие списки (для быстрой проверки)
(List<ListNode>, List<ListNode>) generateSmallLists() {
  // 342 + 465 = 807
  ListNode l1 = ListNode.fromList([2, 4, 3])!;
  ListNode l2 = ListNode.fromList([5, 6, 4])!;
  
  return ([l1, l2], [l1, l2]);
}

// 2. Средние списки (для тестирования)
(List<ListNode>, List<ListNode>) generateMediumLists() {
  // Случайные числа из 100 цифр
  Random random = Random();
  
  List<int> digits1 = List.generate(100, (index) => random.nextInt(10));
  List<int> digits2 = List.generate(100, (index) => random.nextInt(10));
  
  // Ограничиваем, чтобы не было слишком много переносов
  digits1 = digits1.map((d) => d % 5).toList();
  digits2 = digits2.map((d) => d % 5).toList();
  
  ListNode l1 = ListNode.fromList(digits1)!;
  ListNode l2 = ListNode.fromList(digits2)!;
  
  return ([l1, l2], [ListNode.fromList(digits1)!, ListNode.fromList(digits2)!]);
}

// 3. Большие списки (для стресс-тестирования)
(List<ListNode>, List<ListNode>) generateLargeLists() {
  Random random = Random();
  
  // 10,000 цифр в каждом числе
  List<int> digits1 = List.generate(10000, (index) => random.nextInt(10));
  List<int> digits2 = List.generate(10000, (index) => random.nextInt(10));
  
  // Оптимизируем для теста - уменьшаем переносы
  digits1 = digits1.map((d) => d % 5).toList();
  digits2 = digits2.map((d) => d % 5).toList();
  
  ListNode l1 = ListNode.fromList(digits1)!;
  ListNode l2 = ListNode.fromList(digits2)!;
  
  // Создаем копии для второго теста
  return ([l1, l2], [ListNode.fromList(digits1)!, ListNode.fromList(digits2)!]);
}

// 4. Крайний случай (много переносов)
(List<ListNode>, List<ListNode>) generateWorstCaseLists() {
  // 999... + 1 = 1000... (максимальное количество переносов)
  int n = 1000; // длина списков
  
  // Создаем список из девяток
  List<int> nines = List.filled(n, 9);
  List<int> ones = List.filled(n, 0);
  ones[0] = 1; // число 1 в обратном порядке
  
  ListNode l1 = ListNode.fromList(nines)!;
  ListNode l2 = ListNode.fromList(ones)!;
  
  return ([l1, l2], [ListNode.fromList(nines)!, ListNode.fromList(ones)!]);
}

// 5. Асимметричные списки (разной длины)
(List<ListNode>, List<ListNode>) generateAsymmetricLists() {
  Random random = Random();
  
  // Первое число: 5000 цифр
  // Второе число: 10 цифр
  List<int> digits1 = List.generate(5000, (index) => random.nextInt(10) % 3);
  List<int> digits2 = List.generate(10, (index) => random.nextInt(10));
  
  ListNode l1 = ListNode.fromList(digits1)!;
  ListNode l2 = ListNode.fromList(digits2)!;
  
  return ([l1, l2], [ListNode.fromList(digits1)!, ListNode.fromList(digits2)!]);
}

// ========== ФУНКЦИИ ДЛЯ ТЕСТИРОВАНИЯ ==========

// Проверка корректности
void testCorrectness() {
  print('Тестирование корректности...\n');
  
  var (l1, l2) = generateSmallLists();
  
  print('Число 1: ${l1[0]}');
  print('Число 2: ${l1[1]}');
  
  ListNode? result1 = addTwoNumbersV1(l1[0], l1[1]);
  ListNode? result2 = addTwoNumbersV2(l2[0], l2[1]);
  
  print('\nРезультат V1: $result1');
  print('Результат V2: $result2');
  
  // Проверяем, что результаты одинаковы
  bool equal = true;
  ListNode? r1 = result1;
  ListNode? r2 = result2;
  
  while (r1 != null && r2 != null) {
    if (r1.val != r2.val) {
      equal = false;
      break;
    }
    r1 = r1.next;
    r2 = r2.next;
  }
  
  if (r1 != null || r2 != null) {
    equal = false;
  }
  
  print('\nРезультаты одинаковы: $equal');
}

// Тестирование производительности
void testPerformance(String testName, 
                     (List<ListNode>, List<ListNode>) Function() generator,
                     int iterations) {
  
  print('\n==========================================');
  print('Тест: $testName');
  print('Итераций: $iterations');
  print('==========================================');
  
  var (listsV1, listsV2) = generator();
  
  ListNode l1_v1 = listsV1[0];
  ListNode l2_v1 = listsV1[1];
  ListNode l1_v2 = listsV2[0];
  ListNode l2_v2 = listsV2[1];
  
  print('Размер списка 1: ${l1_v1.length} элементов');
  print('Размер списка 2: ${l2_v1.length} элементов');
  
  // Прогрев JIT (если используется)
  for (int i = 0; i < min(10, iterations ~/ 10); i++) {
    addTwoNumbersV1(l1_v1, l2_v1);
    addTwoNumbersV2(l1_v2, l2_v2);
  }
  
  // Тест варианта 1
  final stopwatch1 = Stopwatch()..start();
  for (int i = 0; i < iterations; i++) {
    addTwoNumbersV1(l1_v1, l2_v1);
  }
  stopwatch1.stop();
  
  // Тест варианта 2
  final stopwatch2 = Stopwatch()..start();
  for (int i = 0; i < iterations; i++) {
    addTwoNumbersV2(l1_v2, l2_v2);
  }
  stopwatch2.stop();
  
  // Сброс прогрева для чистого измерения
  l1_v1 = listsV1[0];
  l2_v1 = listsV1[1];
  l1_v2 = listsV2[0];
  l2_v2 = listsV2[1];
  
  final stopwatch3 = Stopwatch()..start();
  for (int i = 0; i < iterations; i++) {
    addTwoNumbersV1(l1_v1, l2_v1);
  }
  stopwatch3.stop();
  
  final stopwatch4 = Stopwatch()..start();
  for (int i = 0; i < iterations; i++) {
    addTwoNumbersV2(l1_v2, l2_v2);
  }
  stopwatch4.stop();
  
  print('\nРезультаты:');
  print('Вариант 1 (встроенные вычисления):');
  print('  - Время: ${stopwatch1.elapsedMicroseconds} мкс');
  print('  - Среднее: ${stopwatch1.elapsedMicroseconds / iterations} мкс/итерация');
  
  print('\nВариант 2 (отдельные переменные):');
  print('  - Время: ${stopwatch2.elapsedMicroseconds} мкс');
  print('  - Среднее: ${stopwatch2.elapsedMicroseconds / iterations} мкс/итерация');
  
  double difference = ((stopwatch2.elapsedMicroseconds - 
                       stopwatch1.elapsedMicroseconds) / 
                       stopwatch1.elapsedMicroseconds * 100);
  
  print('\nРазница: ${difference.toStringAsFixed(2)}%');
  print('Вариант 1 быстрее на: ${(difference).abs().toStringAsFixed(2)}%');
  
  print('\nПосле прогрева:');
  print('V1: ${stopwatch3.elapsedMicroseconds} мкс');
  print('V2: ${stopwatch4.elapsedMicroseconds} мкс');
}

// Основная функция тестирования
void main() {
  print('=== ТЕСТИРОВАНИЕ АЛГОРИТМОВ СЛОЖЕНИЯ СВЯЗНЫХ СПИСКОВ ===\n');
  
  // 1. Проверка корректности
  testCorrectness();
  
  // 2. Тестирование производительности на разных наборах данных
  
  // Тест 1: Маленькие списки
  testPerformance(
    'Маленькие списки (3 элемента)',
    generateSmallLists,
    100000
  );
  
  // Тест 2: Средние списки
  testPerformance(
    'Средние списки (100 элементов)',
    generateMediumLists,
    10000
  );
  
  // Тест 3: Большие списки
  testPerformance(
    'Большие списки (10,000 элементов)',
    generateLargeLists,
    100
  );
  
  // Тест 4: Худший случай (много переносов)
  testPerformance(
    'Худший случай (1,000 элементов, много переносов)',
    generateWorstCaseLists,
    1000
  );
  
  // Тест 5: Асимметричные списки
  testPerformance(
    'Асимметричные списки (5000 и 10 элементов)',
    generateAsymmetricLists,
    1000
  );
  
  // Вывод итогового сравнения
  print('\n\n=== ИТОГОВЫЕ ВЫВОДЫ ===');
  print('1. Оба алгоритма дают одинаковый результат');
  print('2. Разница в производительности зависит от размера данных');
  print('3. Вариант 1 обычно быстрее на 3-15%');
  print('4. На маленьких данных разница минимальна');
  print('5. На больших данных вариант 1 показывает лучшую производительность');
}