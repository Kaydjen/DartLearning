import 'dart:io';
import '../data/MenuMassages.dart';
import '../sys/Console.dart';

enum menuTypes {
    main,
    secondary
}

class Menu {
    static Map<menuTypes, Map<int, ChoosableOptions>> menuType = {
        menuTypes.main: MenuMessages.firstMenuOptions,
        menuTypes.secondary: MenuMessages.secondMenuOptions,
    };
    static void runMenu(menuTypes menu){
        Console.clear();
        Map<int, ChoosableOptions> optionsMap = _validateMenu(menu);
        
        for (var el in optionsMap.keys) 
            print("${el}. ${optionsMap[el]!.description} ");

        stdin.echoMode = false; // Disable echoing typed characters 

        int? input = int.tryParse(stdin.readLineSync()!);
        if(optionsMap.containsKey(input))
        {
            stdin.echoMode = true; 
            optionsMap[input]?.onSelected?.call();
        }
        else invalidInput(menu);

        stdin.echoMode = true; 
    }
    static void runMenuWithDelay(menuTypes menu, [int delay = 1000]){
        sleep(Duration(milliseconds: delay));
        runMenu(menu);
    }
    static void invalidInput(menuTypes menu){
        Console.defColor(false);
        stdout.write("Please, choose the right option \nRestarting");
        for (var i = 0; i < 3; i++) {
          stdout.write('.');
          sleep(Duration(milliseconds: 750));
        }
        runMenu(menu);
    }

    static Map<int, ChoosableOptions> _validateMenu(menuTypes type){
        if(!menuType.containsKey(type) || menuType[type]!.isEmpty){ // I know this is bad code, but who cares :D
            print("INVALID: something went wrong in ${runMenu.toString()} with сам разберешься c чем");
            Map<int, ChoosableOptions> mapForInvalids = {
                0: ChoosableOptions(
                    "INVALID",
                    () => print("INVALIDISZCIE")
                )
            };
            return mapForInvalids;
        }
        return menuType[type]!;        
    }
}
