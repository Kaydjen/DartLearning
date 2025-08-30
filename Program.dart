import '00_hub_core/menu_system/menu.dart';
import '00_hub_core/menu_system/welcome_menu.dart';
import '01_sys/Console.dart';
import '06_cli_economic_simulation/lib/domain/entities/entity.dart';
import '06_cli_economic_simulation/lib/domain/repositories/entity_repo.dart';

void main() {
    Console.setConsoleSize(Console.height, Console.width);
    WelcomeMenu.showWelcomeMessage();
    Menu.runMenu(menuTypes.main);  

    // EntityRepo repo = EntityRepo({
        // "1": Entity("xui", "dwa"),
        // "2": Entity("xui", "try"),
    // });
// 
    // print("${repo["1"]!.id}: ${repo["1"]!.name}");
}


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