import 'dart:io';
import '../../01_sys/color.dart';
import '../../01_sys/prompt_handler.dart';
import '../data/menu_massages.dart';
import '../../01_sys/console.dart';

enum menuTypes {
    main,
    junkDrawer,
    bigProjects
}

class Menu {
    static Map<menuTypes, Map<int, ChoosableOptions>> menuType = {
        menuTypes.main: MenuMessages.firstMenuOptions,
        menuTypes.junkDrawer: MenuMessages.junkDrawerOptions,
        menuTypes.bigProjects: MenuMessages.bigComplitedProjectsOptions,
    };
    static void runMenu(menuTypes menu){
        Console.clear();
        Map<int, ChoosableOptions> optionsMap = _validateMenu(menu);
        
        int hight = ((Console.height - optionsMap.length) / 2).toInt() - 3;

        int biggestLenght = 0;
        for (var el in optionsMap.keys) {
            if(el.toString().length > biggestLenght) 
                biggestLenght = el.toString().length;
        }

        int averageWidth = 0;
        if(biggestLenght == 1){
            averageWidth = 0;
        }
        else{
            optionsMap.forEach((key, value) => averageWidth += key.toString().length);
            averageWidth = (averageWidth / optionsMap.length).toInt();
        }

        int width = 0;
        optionsMap.forEach((key, value) 
            => width += value.description.length + averageWidth + biggestLenght - key.toString().length + 3);
        width = ((Console.width - (width / optionsMap.length))/2).toInt();
        
        print('${'\n' * hight}');

        for (var el in optionsMap.keys) 
        {
            print("${' ' * width}\x1B[91m${el}${' ' 
            * (biggestLenght - el.toString().length)} - ${' ' * averageWidth}\x1B[90m${optionsMap[el]!.description}");   
            /* 
            print('\n${' ' * ((74 - el.toString().length) / 2).toInt()}${el}');
            int lenght = ((74 - optionsMap[el]!.description.length - 2) / 2).toInt();
            print("\n${el.toString() * (lenght / el.toString().length).toInt()} ${optionsMap[el]!.description} ${el.toString() * (lenght / el.toString().length).toInt()}");
        */  
        }

        //stdin.echoMode = false; // Disable echoing typed characters 
        stdout.write('\n${' ' * 37}');
        stdout.write("\u001b[38;5;196m");
        int? input = int.tryParse(stdin.readLineSync()!);
        stdout.write("\u001b[38;5;255m");
        if(optionsMap.containsKey(input))
        {
            stdin.echoMode = true; 
            optionsMap[input]?.onSelected?.call();
        }
        else invalidInput(menu);

        //stdin.echoMode = true; 
    }
    static void runMenuWithDelay(menuTypes menu, [int delay = 1000]){
        sleep(Duration(milliseconds: delay));
        runMenu(menu);
    }
    static void invalidInput(menuTypes menu){
        Color.red;
        Prompt.invalidInput();
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
