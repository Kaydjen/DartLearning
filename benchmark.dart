import 'package:benchmark_harness/benchmark_harness.dart';
// us. это микросекунды
//3.1407 микросекунды — 0.00314 миллисекунды - 0.00000314 секунды (то есть 3.14×10⁻⁶ с)
class Benchmark extends BenchmarkBase {
    Benchmark() : super('Fuck world!');

    @override
    void run() {
        Solution.findMedianSortedArrays([1,4], [2,3]);
    } //
}




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
