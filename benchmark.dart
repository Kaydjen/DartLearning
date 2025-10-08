import 'package:benchmark_harness/benchmark_harness.dart';

class Benchmark extends BenchmarkBase {
    Benchmark() : super('Fuck world!');

    @override
    void run() {

    } //
}
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
    static List<int> twoSum(List<int> nums, int target) {
        var map = Map<int,int>();
        for (var i = 0; i < nums.length; i++) {
            int temp = target-nums[i];
            if(map.containsKey(temp)){
                return [map[temp]!, i];
            }
            map[nums[i]] = i;
        }
        return [];
    }
} */
