import 'dart:math';

import '../01_sys/Console.dart';

class WordHunterRundomDraw {
    static void run(){
        Console.clear();
        Console.defColor();
        final length = Console.promptValidateInt("Quantity of letters in word: ", countOfLinesToClear: 3);
        final word = Console.promptValidate("Word to search for: ", countOfLinesToClear: 3);
        final doShowWord = Console.promptValidate(
            "See each word: ${Console.symbolColorDef("enter something")} "
            "\nSee only resault: ${Console.symbolColorDef("press enter on empty line")}"
            "\nChoose the option: ", 
            countOfLinesToClear: 5).isEmpty ? false : true;
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
                print("${Console.symbolColorDef(maxCounter.toString())}.${Console.symbolColorAddit(counter.toString())} - ${letters}");
            
            if(letters.contains(word)) break;
        }
        print("HERE IT IS ${Console.symbolColorAddit(maxCounter.toString())}-billion "
        " ${Console.symbolColorAddit(counter.toString())} - ${Console.symbolColorDef(letters)}}");
    }
}