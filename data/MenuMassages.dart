import '../P2/OutputNegr.dart';
import '../menu_system/Menu.dart';
import '../P2/Statements.dart';
import '../menu_system/WelcomeMenu.dart';
import 'VisualTextElements.dart';

class MenuMessages {
  static final Map<int, ChoosableOptions> firstMenuOptions = {
    0: ChoosableOptions
    ("This is the way", 
    _thisIsTheWay
    ),
    1: ChoosableOptions
    ("Run old scripts", 
    () => Menu.runMenu(menuTypes.secondary)
    ),
    2: ChoosableOptions
    ("Run Тo-Do (Not implimented yet)", 
    () => Menu.runMenu(menuTypes.secondary)
    ),
    666: ChoosableOptions
    ("Show the welcome-menu again", 
    WelcomeMenu.showWelcomeMessageAgain
    ),
  };
  static final Map<int, ChoosableOptions> secondMenuOptions = {
    0: ChoosableOptions
    ("Previous", 
    () => Menu.runMenu(menuTypes.main)
    ),
    1: ChoosableOptions
    ("Run OutputNegr.run", 
    OutputNegr.run
    ),
    2: ChoosableOptions
    ("Run OutputNegr.runNegra", 
    OutputNegr.runNegra
    ),
    3: ChoosableOptions
    ("Run Statements.runOddEven", 
    Statements.runOddEven
    ),
    4: ChoosableOptions
    ("Show penis", 
    _showPenis
    ),
};
  static void _thisIsTheWay(){
    print("This is the way");
    Menu.runMenuWithDelay(menuTypes.main);
  }
  static void _showPenis(){
    print(VisualTextElements.penis);
    Menu.runMenuWithDelay(menuTypes.main, 1500);
  }
}

class ChoosableOptions {
    final String description;
    final void Function()? onSelected;
    ChoosableOptions(this.description, this.onSelected);
}
