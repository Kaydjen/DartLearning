import 'Cart.dart';
//import 'menu_system/Menu.dart';
//import 'menu_system/WelcomeMenu.dart';
import 'ShowLetters.dart';
import 'sys/Console.dart';

void main() {
    Console.setConsoleSize(Console.height, Console.width);
    
    //ShowLetters.run(8, 2147483646);
    CartUI.showAllCarts();
    print("");
    Cart.addNewCart("New Cart", {"Invalid": 1});
    CartUI.showAllCarts();
    print("");
    Cart.tryAddProducts("New Cart", {"Invalid":1 });
    CartUI.showAllCarts();
    print("");
    print("");
    Cart.mergeCarts(
        "Cart Kaydjen", 
        "Cart Fuad",
        "Our Cart",
        doRemovePreviousCarts: false);
    CartUI.showAllCarts();

    print("");
    Cart.compare("Cart Kaydjen", "Our Cart");
    CartUI.createCart();
    CartUI.showAllCarts();

    // WelcomeMenu.showWelcomeMessage();
    // Menu.runMenu(menuTypes.main);
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