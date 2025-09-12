import '../../02_big_complited_projects/cart/cart_ui.dart';
import '../../02_big_complited_projects/flashcards/sm2_ui.dart';
import '../../03_junk_drawer/P2/Statements.dart';
import '../../03_junk_drawer/p2/output_negr.dart';
import '../../03_junk_drawer/word_hunter_random_draw.dart';
import '../../03_junk_drawer/word_frequency.dart';
import '../menu_system/Menu.dart';
import '../menu_system/welcome_menu.dart';
import 'visual_text_elements.dart';

class MenuMessages {
    static final Map<int, ChoosableOptions> firstMenuOptions = {
        0: ChoosableOptions
        ("This is the way", 
        _thisIsTheWay
        ),
        1: ChoosableOptions
        ("Show junk drawer scripts", 
        () => Menu.runMenu(menuTypes.junkDrawer)
        ),
        2: ChoosableOptions
        ("Show big complited projects", 
        () => Menu.runMenu(menuTypes.bigProjects)
        ),
        666: ChoosableOptions
        ("Show the welcome-menu again", 
        WelcomeMenu.showWelcomeMessageAgain
        ),
    };
    static final Map<int, ChoosableOptions> junkDrawerOptions = {
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
        ("Word Frequency Counter", 
        WordFrequency.run
        ),
        5: ChoosableOptions
        ("Luck Of The Draw - Word Hunter", 
        WordHunterRundomDraw.run
        ),
        6: ChoosableOptions
        ("Show penis", 
        _showPenis
        ),
    };
    static final Map<int, ChoosableOptions> bigComplitedProjectsOptions = {
        0: ChoosableOptions
        ("Previous", 
        () => Menu.runMenu(menuTypes.main)
        ),
        1: ChoosableOptions
        ("Run Cart", 
        CartUI.mainMenu
        ),
        2: ChoosableOptions
        ("Run SM2", 
        SM2UI.mainMenu
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
