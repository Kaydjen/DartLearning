import 'dart:io';
import '../data/visual_text_elements.dart';
import '../../01_sys/console.dart';
import 'Menu.dart';

class WelcomeMenu {
  static void showWelcomeMessageAgain(){
      showWelcomeMessage();
      Menu.runMenu(menuTypes.main);
  }
  static void showWelcomeMessage() async {
    Console.defColor();
    // print logo line by line with delay
    for (String el in VisualTextElements.mainWelcomeLogo.split('|')) {
      stdout.write(el);
      sleep(Duration(milliseconds: 20));
      //await Future.delayed(Duration(milliseconds: 5));
    }

    // manage input
    print('\t\t\tPress Enter to continue...');
    stdin.echoMode = false; // Disable echoing typed characters
    //stdin.lineMode = false;  // Disable requiring Enter
    String? input = stdin.readLineSync();
    easterEgg(input);
    stdin.echoMode = true;
  }

  static void easterEgg(String? input) {
        if(input == null) return;
        if (input.compareTo("10(13)6660(13)1") == 0) {
            print("1110000110100001001101101100100000010101111000000000000001");
            print('''
No way, this can’t be real!
Is that really you?
Long time, no see!
How's it going? Are you all right?''');
            String? input = stdin.readLineSync();
            if(input!.isEmpty) return;
        }
        else if(input.compareTo("") == 0){
            
        }
    } 
}