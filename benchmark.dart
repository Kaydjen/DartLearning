import 'package:benchmark_harness/benchmark_harness.dart';

class Benchmark extends BenchmarkBase {
    Benchmark() : super('Fuck world!');

    @override
    void run() {

    } 
}
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
