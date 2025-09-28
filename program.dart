import '00_hub_core/menu_system/menu.dart';
import '00_hub_core/menu_system/welcome_menu.dart';
import '01_sys/console.dart';

void main() {
    Console.setConsoleSize(height: Console.heightInit, width: Console.widthInit);
    WelcomeMenu.showWelcomeMessage();
    Menu.runMenu(menuTypes.main);  
}





























/* 

class Solution {
    int lengthOfLongestSubstring(String s) {
        var map = Map<String, bool>();
        for (int i = 0; i < s.length; i++) {
            if(map.containsKey(s[i])) map.clear();
            else map[s[i]];

        }
    }
}


 */
























/* 
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
/* 
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
/* 

961002FAB836819B599E770AA25FF02BFF1697D1D051140062066A5FF47D6712
961002fab836819b599e770aa25ff02bff1697d1d051140062066a5ff47d6712

 */
/* 
- Cart with name [name] was added;
- Products [products] were added to cart [cart name];
- Cart [name] and cart [name] were merged:
    added: ...
    removed: ...
    changed: ...

 */

   // Console.setConsoleSize(Console.height, Console.width);
   // WelcomeMenu.showWelcomeMessage();
   // Menu.runMenu(menuTypes.main);

/*
 // for (var i = 0; i < count; i++) 
 
  int i = 10;
  while(i > 9){
    print("${i} while");
    if(i == 11) break;
    i++;
  }
  i = 10;
print("-----------------------");
  do{
    print("${i} do while");
    if(i == 11) break;
    i++;
  }while(i > 11000);

*/ 

/* 
 Random rnd = Random();
  if(rnd.nextBool()) print("Your are true gay");
  else print("You are straingt");

  String? xui = stdin.readLineSync();
  main();
  */


/*
//import 'P2/OutputNegr.dart';
//import 'P2/Statements.dart';

void main(List<String> args) {
  //Outputnegr.Run();
  //Statements.RunOddEven(); 
}

*/