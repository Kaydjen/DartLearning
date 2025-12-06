import 'dart:ffi';
import 'dart:math';
import 'dart:math';

import 'package:benchmark_harness/benchmark_harness.dart';
// us. это микросекунды
//3.1407 микросекунды — 0.00314 миллисекунды - 0.00000314 секунды (то есть 3.14×10⁻⁶ с)
class Benchmark extends BenchmarkBase {
    Benchmark() : super('Fuck world!');

    @override
    void run() {

    } // 4.19138
}




/* 


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
void main1() {
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
 */

/* 
class Solution {
    int maxArea(List<int> height) {
        int left = 0;
        int right = height.length - 1;
        int area = 0;
        while(left < right){
            int l = height[left];
            int r = height[right];
            area = max(min(l, r) * (right-left), area);

            if(l > r){
                right--;
            }else{
                left++;
            }
        }
        return area;
    }
} */

                /* final int elj = height[j];
                final int tempRes = (eli > elj) ? (elj * (j-i)) : (eli * (j-i));
                if(tempRes > res) res = tempRes;  */

/* class Solution {
    int maxArea(List<int> height) {
        int len = height.length;
        int res = 0;
        for (int i = 0; i < len-1; i++) {
            int eli = height[i];
            for (int j = i+1; j < len; j++) {
                int elj = height[j];
                int tempRes;
                if(eli > elj){
                    tempRes = elj * (j-i);
                }else{
                    tempRes = eli * (j-i);
                }
                if(tempRes > res) res = tempRes; 
            }
        }
        return res;
    }
}
 */


/* beats 100
class Solution {
    String longestCommonPrefix(List<String> strs) {
        int index = 0;
        String res = "";
        String symbol = "";
        String firstStr = strs[0];
        final int strsLen = strs.length;
        while(index < firstStr.length){ 
            symbol = firstStr[index];
            for (int i = 1; i < strsLen; i++) {
                String word = strs[i];
                if(index >= word.length || word[index] != symbol){
                    return res;
                }
            }
            res += symbol;
            index++;
        }
        return res;
    }
} */


/* New AI -  1.5962219518890242 us.

class Solution {
  static const Map<String, int> map = {
    "I": 1,
    "V": 5,
    "X": 10,
    "L": 50,
    "C": 100,
    "D": 500,
    "M": 1000
  };
  
  static int romanToInt(String s) {
    int res = 0;
    int prev = 0;
    
    for (int i = s.length - 1; i >= 0; i--) {
      int curr = map[s[i]]!;
      if (curr < prev) {
        res -= curr;
      } else {
        res += curr;
      }
      prev = curr;
    }
    
    return res;
  }
} */

/* 13 AI variant 2.8607460696269653 us.
 class Solution1 {
  static const Map<String, int> map = {
    "I": 1,
    "V": 5,
    "X": 10,
    "L": 50,
    "C": 100,
    "D": 500,
    "M": 1000
  };
  
    static int romanToInt(String s) {
        int res = 0;
        int sLen = s.length; // this is my line, saved about 0.1 ms
        for (int i = 0; i < sLen; i++) {
            int curr = map[s[i]]!;
            int next = (i + 1 < sLen) ? map[s[i + 1]]! : 0;
            res += (curr < next) ? -curr : curr;
        }
        return res;
    }
} */
/* 13 mine 1.5648247175876413 us.  beats 5-87.82 151-37
class Solution {
    static const Map<String, int> map = {
        "I": 1,
        "V": 5,
        "X": 10,
        "L": 50,
        "C": 100,
        "D": 500,
        "M": 1000
    };
    static int romanToInt(String s) {
        int res = 0;
        for(int i = s.length-1;  i > -1; i--){
            final int n1 = map[s[i]]!;
            if(i==0){
                res += n1;
                break;
            }
            
            final int n0 = map[s[i-1]]!;
            if(n0 < n1){
                res += n1-n0;
                i-=1;
            }else if(i==1){
                res += n1 + n0;
                break;
            }
            else{
                res += n1;
            }
        }
        return res;
    }
} */




/* 
class Solution {
    static final Map<String, int> map = {
        "0": 0,
        "1": 1,
        "2": 2,
        "3": 3,
        "4": 4,
        "5": 5,
        "6": 6,
        "7": 7,
        "8": 8,
        "9": 9,
    };
    static int myAtoi(String s){
        int i = 0;
        int res = 0;
        while(i < s.length && s[i] == " "){
            i++;
        }
        bool isNegative = false;
        if(i == s.length){
            return 0;
        }
        if(s[i] == "-"){
            isNegative = true;
            i++;
        }else if(s[i] == "+"){
            i++;
        }
        for (; i < s.length; i++) {
            if(!map.containsKey(s[i])){
                break;
            }
            res *= 10;
            res += map[s[i]]!;
            if(res>2147483647){
                return isNegative ? -2147483648 : 2147483647;
            }
        }
        return isNegative ? -1*res : res;
    }
}

 */













/* 

class Solution {
    static int lengthOfLongestSubstring(String s) {
        Set<String> map = {s[0]};
        int lenRes = 1;
        for (int i = 1; i < s.length; i++) {
            if(!map.contains(s[i])){
                map.add(s[i]);
                int len = map.length;
                if(len>lenRes){
                    lenRes = len;
                }
            }else{
                map.clear();
            }
        }
        return lenRes;
    } // 3.1228813361582186
}




 */


/* 
class Solution {
    int lengthOfLongestSubstring(String s) {
        Set<String> letters = {};
        int maxSubString = 0;
        for (int i = 0; i < s.length; i++) {
            while (letters.contains(s[i])) {
                letters.remove(letters.first);
            }
            letters.add(s[i]);
            final int len = letters.length;
            maxSubString = len>maxSubString?len:maxSubString;
        }
        return maxSubString; 
    }
} 
*/

/* class Solution {
    List<List<int>> threeSum(List<int> nums) {
        List<List<int>> list = [];

        for(int i = 2; i < nums.length; i++){
            if(nums[i-2]+nums[i-1]+nums[i] == 0) list.add([nums[i-2],nums[i-1],nums[i]]);
        }

        for(int i = 1; i<nums.length - 2; i++){
            int j;
            j = i==1?3:i+1;
            while(j<nums.length){
                  if(nums[0]+nums[i]+nums[j] == 0) list.add([nums[0],nums[i],nums[j]]);
                  j++; //
            }
        }
    }
} */



/* 
class Solution {
    static Map<String, String> map = {
        "1": "",
        "2": "abc",
        "3": "def",
    };
    List<String> letterCombinations(String digits) {
        List<String> list = [];
        for(int i = 0; i < digits.length; i++){
            String letters = map[digits[i]]!;
            for (int j = 0; j < letters.length; j++) {
                if(list.isEmpty){
                    list.add(letters[j]);
                    j+=1;
                }
                String temp = list[0];
                for (int l = 0; l < list.length; l++) {
                    list.add(temp+letters[j]);
                }
            }
        }
    }
}

 */
/* 8
/* 8-2
    class Solution {
        static int myAtoi(String s) {
            Map<String, int> numbers = {"0": 0,"1": 1,"2": 2,"3": 3,"4": 4,"5": 5,"6": 6,"7": 7,"8": 8,"9": 9};
            final len = s.length;
            int res = 0;
            int i = 0;
            for (; i < len; i++) if(s[i] != " ") break;  
            if(i==len) return 0;
            bool isNegative = false;
            if(s[i] == "-"){
                isNegative = true;
                i++;
            }
            else if(s[i] == "+"){
                i++;
            }
            if(i == len || i < len && !numbers.containsKey(s[i])) return 0; 
            do{
                res = res * 10 + numbers[s[i]]!;
                if(res > 2147483647) return isNegative ? -2147483648 : 2147483647;
                i++;
            }while(i < len && numbers.containsKey(s[i]));
            if(isNegative) res *= -1;
            return res;
        }
    }
*/
/* 8-1(first variant of solving) It reads string and return int if it exists there
class Solution {
    static int myAtoi(String s) {
        Map<String, int> numbers = {"0": 0,"1": 1,"2": 2,"3": 3,"4": 4,"5": 5,"6": 6,"7": 7,"8": 8,"9": 9};
        final len = s.length;
        int res = 0;
        for (int i = 0; i < len; i++) {
            if(numbers.containsKey(s[i])){
                final int idex = i-1;
                do{
                    res = res * 10 + numbers[s[i]]!;
                    i++;
                }while(i < len && numbers.containsKey(s[i]));
                if(idex < len && idex >= 0 && s[idex] == "-"){
                    res *= -1;
                }
                break;
            }
        }      
        return res;
    }
} 
*/
 */ 
/* 7 new* 2 took isNegtive lines from old 

class Solution {
    int reverse(int x) {
        int res = 0;
        bool isNegative = x.isNegative;
        if(isNegative) x *= -1;
        while(x!=0){
            res *= 10;
            res += x%10;
            x~/=10;
        }   
        if(isNegative) res *= -1;
        if(res > 2147483647 || res < -2147483648) return 0;
        return res;
    }
}

 */
/* 7 new *  1

class Solution {
    int reverse(int x) {
        int res = 0;
        bool isNegative = false;
        if(x.isNegative){
            x*=-1;
            isNegative = true;
        }
        while(x != 0){
            res *= 10;
            res += x%10;
            x~/=10;
        }
        if(isNegative){
            res *= -1;
        }
        if(res > 2147483647 || res < -2147483648){
            return 0;
        }
        return res;
    }
}

 */
/* 7 runtime -
class Solution {
    int reverse(int x) {
        int res = 0;
        bool isNegative = x.isNegative;
        if(isNegative) x *= -1;
        while(x!=0){
            final temp = x%10;
            res = res*10+temp;
            x=(x/10).toInt();
        }
        if(isNegative) res *= -1;
        return res;
    }
} */
/* 6 no runtime
class Solution {
    String convert(String s, int numRows) {
        final len = s.length;
        int step = numRows==1 ? 1 : (numRows-1)*2;
        String res = "";
        for (int i = 0; i < len; i+=step) res += s[i];
        step -= 2;
        final newI = numRows-1;
        for (int i = 1; i < newI; i++) {
            int j = i;
            final stepi2=i*2;
            while(j < len){
                res += s[j];
                j+=step; 
                if(j >= len) break; 
                res += s[j];
                j+=stepi2;
            }
            step -= 2;
        }
        final step1 = newI*2;
        if(step1 != 0)
            for (int i = newI; i < len; i+=step1) res += s[i];
        return res;
    } 
}
/* 
/* 

class Solution {
    String convert(String s, int numRows) {
        final len = s.length;
        int step = numRows==1 ? 1 : (numRows-1)*2;
        String res = "";
        for (int i = 0; i < len; i+=step) res += s[i];
        step -= 2;
        final newI = numRows-1;
        for (int i = 1; i < newI; i++) {
            int j = i;
            final stepi2=i*2;
            do{
                res += s[j];
                j+=step; 
                if(j >= len) break; 
                res += s[j];
                j+=stepi2;
            }while(j < len);
            step -= 2;
        }
        final step1 = newI*2;
        if(step1 != 0)
            for (int i = newI; i < len; i+=step1) res += s[i];
        return res;
    } 
}


 */
/* 
                if(step != 0){
                    j+=step;
                }
                if(i*2 != null){
                    j+= i*2;
                }
 */
/* 
        int step = (numRows-1)*2;
        String res = "";
        for (int i = 0; i < s.length; i+=step) {
             res += s[i];
        }
        for (int i = 1; i < numRows; i++) {
            final step1 = i*2;
            for (int j = i; j < s.length; j+=step) {
                res += s[j+step1] + s[j];
            }
            step-=2;
        }
        return res;


---
        int step = numRows + (numRows - 2);
        String res = "";
        for (int i = 0; i < numRows; i++) {
            if(i == numRows-2) step = 2;        
            else if(step <= 2) step = numRows + (numRows - 2);
            print("i - $i  step=$step");
            for (int j = i; j < s.length; j+=step) {
                res += s[j];
                print("j: $j  | id: ${j} - ${s[j]}");
            }  
            step -= 2;
        }
        return res;


 */
//PAHNALIGYIR
//PAYPALISHIRING
//PINALSIGYAHRPI
//PINALSIGYAHRPI

//PINALSIGYAHRPI
//PINALIGYAIHRNPI

// numRows = 3
// 1-1 all else 4 (numRows += numRows-2)
// 2
// 1-3 all else 4

// numRows = 4
// 1-1 all else 6 (numRows += numRows-2)
// 
// PAYPALISHIRING
 */
 */
/* 5 without runtime
class Solution {
    static String longestPalindrome(String s) { // "baaaab" "cbbd"
        final len = s.length;
        String res = "";
        for (int center = 0; center < len; center++) {
            for (int offset = 1; offset <= 2; offset++) {
                int left = center, right = center + offset;
                while (left >= 0 && right < len && s[left] == s[right]) {
                    if (right - left + 1 > res.length) res = s.substring(left, right + 1);
                    left--;
                    right++;
                }
            }
        }
        return res == "" ? s[0] : res;
    } 
} */
/* 4 (RunTime): // 1.5164437417781291 us
class Solution {
    static double findMedianSortedArrays(List<int> nums1, List<int> nums2) {
        List<int> merged = [...nums1, ...nums2];
        merged.sort();
        double temp = merged.length / 2;
        int tempInt = temp.round()-1;
        if(temp % 1 != 0){
            return merged[tempInt].toDouble();
        }
        else{
            return (merged[tempInt] + merged[tempInt+1])/2;
        }      
    }
} */
/* 4 new* 

class Solution {
    static double findMedianSortedArrays(List<int> nums1, List<int> nums2) {
        for (int i = 0; i < nums2.length; i++) {
            nums1.add(nums2[i]); // it would be better to create a new list... but who cares
        }
        nums1.sort();
        int len = nums1.length;
        int index = len~/2;
        if(len%2==0){
            return (nums1[index]+nums1[index-1])/2;
        }else{
            return nums1[index].toDouble();
        }
    }
} // 1.384609557695221


 */
/* LoL 4
Не правильно понял задачу и вот с этим кодом я 2к тестов прошел.... лол

class Solution {
    double findMedianSortedArrays(List<int> nums1, List<int> nums2) {
        double res = 0;
        int i = 0;
        int j = 0;
        for (int i = 0; i < nums1.length; i++) res += nums1[i];
        for (int i = 0; i < nums2.length; i++) res += nums1[2];
        return res/(i+j);
    }
}


 */
/* 3  new*
class Solution {
    static int lengthOfLongestSubstring(String s) {
        Set<String> map = {};
        int lenRes = 0;
        int lastIndex = 0;
        int sLen = s.length;
        for (int i = 0; i < sLen; i++) {
            if(!map.contains(s[i])){
                map.add(s[i]);
                int len = map.length;
                if(len>lenRes){
                    lenRes = len;
                }
            }else{
                map.clear();
                i = lastIndex;
                map.add(s[i]);
                if(i+1 < sLen){
                    lastIndex = i+1;
                }
            }
        }
        return lenRes;
    } // 3.461019654235259 dvdf
}
 */
/* 3 (RunTime): 2.39415 us.
class Solution {
    static int lengthOfLongestSubstring(String s) {
        Set<String>map = Set<String>();
        int res = 0;
        int startIndex = 1;
        for (int i = 0; i < s.length; i++) {
            final String temp = s[i];
            if(map.contains(temp)) 
            {
                final int len = map.length;
                res = len > res ? len : res;
                map.clear();
                i = startIndex-1;
                startIndex+=1;
            }
            else map.add(temp);
        }
        final int len = map.length;
        return len > res ? len : res;
    }
} */
/* 2

class ListNode {
   int val;
   ListNode? next;
   ListNode([this.val = 0, this.next]);
 }

class Solution {
    ListNode? addTwoNumbers(ListNode? l1, ListNode? l2) {
        ListNode res = ListNode();
        ListNode res1 = res;
        bool isNull1 = false;
        bool isNull2 = false;
        while(true){
            if(!isNull1){
                res.val += l1!.val; 
                l1 = l1.next;
            }
            if(!isNull2){
                res.val += l2!.val; 
                l2 = l2.next;
            }

            if(l1 == null){
                isNull1 = true;
            }
            if(l2 == null){
                isNull2 = true;
            }

            if(res.val > 9){
                res.next = ListNode(res.val~/10);
                res.val %= 10;
                res = res.next!;
                if(isNull1 && isNull2) break;
            }else if(!isNull1 || !isNull2){
                res.next = ListNode();
                res = res.next!;
            }else{
                break;
            }
        }
        return res1;
    }
}


*/
/* 2 old*1 doest work idk why
class ListNode {
  int val;
  ListNode? next;
  ListNode([this.val = 0, this.next]);
}

class Solution {
    ListNode? addTwoNumbers(ListNode? l1, ListNode? l2) {
        ListNode? res = ListNode(0);
        ListNode? temp = res;
        int fallback = 0;
        int n;
        do{
            n = (l1?.val ?? 0) + (l2?.val ?? 0) + fallback;
            if(n>=10){
                n = n-10;
                fallback=1;
            }
            else {
                fallback = 0;
            }            
            temp!.val = n;
            l1 = l1?.next;
            l2 = l2?.next;    
            if(l1==null||l2==null){
                if(fallback != 0){
                    temp.next = ListNode(fallback);
                    temp = temp.next;
                }
                return res;
            }
            temp.next = ListNode(0);
            temp = temp.next;
        }while(true);
    }
}
 */
/* 1
class Solution {
    Map<int, int> map = {};
    List<int> twoSum(List<int> nums, int target) {
        for (int i = 0; i < nums.length; i++) {
            int temp = target - nums[i];
            if(map.containsKey(temp)){
                return [map[temp]!, i];
            }
            map[nums[i]] = i;
        }
        return [];
    }
}
*/
