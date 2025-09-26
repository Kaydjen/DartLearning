import '00_hub_core/menu_system/menu.dart';
import '00_hub_core/menu_system/welcome_menu.dart';
import '01_sys/cli.dart';
import '01_sys/console.dart';

void main() {
    Console.setConsoleSize(height: Console.heightInit, width: Console.widthInit);
    WelcomeMenu.showWelcomeMessage();
    Menu.runMenu(menuTypes.main);  
}

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