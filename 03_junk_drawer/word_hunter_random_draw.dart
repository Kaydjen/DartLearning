import 'dart:io';
import 'dart:math';

import '../01_sys/color.dart';
import '../01_sys/console.dart';
import '../01_sys/prompt_handler.dart';

class WordHunterRundomDraw {
    static void run(){
        Console.clear();
        final length = Prompt.promptValidateIntDouble("Quantity of letters in word: ", countOfLinesToClear: 3).toInt();
        print("${Color.set(ColorTypes.brightCyan, str: "Attention!!!")} if you'll write symbols apart from letters - program won't find it. ONLY LETTERS");
        final word = Prompt.promptValidate("Word to search for: ", countOfLinesToClear: 3).toLowerCase();
        print(
            "See each word: ${Color.set(ColorTypes.brightCyan, str:"enter something")} "
            "\nSee only resault: ${Color.set(ColorTypes.brightCyan, str:"press enter on empty line")}"
            "\nChoose the option: ");
        final input = stdin.readLineSync();
        final doShowWord = input == null || input.isEmpty ? false : true;
        Random rnd = Random();
        int counter = 0;
        int maxCounter = 0;
        String letters = "";
        while(true){
            letters = "";
            for (int j = 0; j < length; j++) {
                letters += String.fromCharCode(97 + rnd.nextInt(26));
            }
            counter++;
            if(counter == 2000000000) {
                maxCounter++;
                counter = 0;
            }
            if(doShowWord)
                print("${Color.set(ColorTypes.brightCyan, str:maxCounter.toString())}.${Color.set(ColorTypes.brightCyan, str:counter.toString())} - ${letters}");
            
            if(letters.contains(word)) break;
        }
        print("HERE IT IS ${Color.set(ColorTypes.brightCyan, str:maxCounter.toString())}-billion "
        " ${Color.set(ColorTypes.brightCyan, str:counter.toString())} - ${Color.set(ColorTypes.brightCyan, str:letters)}}");
    }
}