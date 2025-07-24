import 'dart:io';
import '../P2/OutputNegr.dart';
import '../MainMenu.dart';
import '../P2/Statements.dart';
import '../WelcomeMenu.dart';

class MenuMessages {
  static Map<int, ChoosableOptions> firstMenuOptions = {
    0: ChoosableOptions
    ("This is the way", 
    _thisIsTheWay
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
    666: ChoosableOptions
    ("Show the welcome-menu again", 
    WelcomeMenu.showWelcomeMessageAgain
    ),
  };

  static void _thisIsTheWay(){
    print("This is the way");
    sleep(Duration(seconds: 1));
    MainMenu.run();
  }
}

class ChoosableOptions {
  String description = "";
  void Function()? onSelected;
  ChoosableOptions(this.description, this.onSelected);
}
