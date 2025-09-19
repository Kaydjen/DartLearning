import '../00_hub_core/data/menu_massages.dart';
import 'console.dart';
import 'prompt_handler.dart';

class Display {
    static void optionsAndHandleChoice(Map<int, ChoosableOptions> options){
        Console.clear();
        String? message = "\nEnter option: ";
        for (var optionDescription in options.entries) 
        print("\u001b[38;5;196m${optionDescription.key}.\u001b[38;5;255m ${optionDescription.value.description}");
        //Console.defColor();
        while(true){
            final key = Prompt.validateIntDouble(message, countOfLinesToClear: 3).toInt();
            if(options.containsKey(key)) {
                options[key]!.onSelected!.call();            
                break;
            }
        }
    }
}