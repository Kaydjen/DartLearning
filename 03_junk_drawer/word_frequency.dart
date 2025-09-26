/* 

### 1. Word Frequency Counter

Problem: Given a string, return a map of each word and how many times it appears.
Skills: Map<String, int>, splitting strings, loop logic.

> 💡 *"the cat and the dog and the mouse"*
> 👉 {the: 2, cat: 1, and: 2, dog: 1, mouse: 1}

 */

import 'dart:io';
import '../00_hub_core/menu_system/Menu.dart';
import '../01_sys/color.dart';
import '../01_sys/console.dart';
import '../01_sys/prompt_handler.dart';

class WordFrequency{
    static void run(){
        Console.clear();
        Color.red;
        Console.placeCursor((Console.height/2).toInt());
        stdin.echoMode = true; 
        print("  Please, enter text");

        Map<String, int> txt = Map();
        String? text = stdin.readLineSync();
        if(text == null){
            Prompt.invalidInput(errorMessage: "Please, enter a proper text");
            run();
            return;
        }
        List<String> newText = text.toLowerCase().replaceAll(new RegExp(r'[^\w\s]+'),'').split(' ');

        for (var el in newText) {
            if(txt.containsKey(el)) txt[el] = txt[el]! + 1;
            else txt.putIfAbsent(el, () => 1);
        }
        for (var word in txt.keys) 
            print("    ${word}: ${txt[word]}");

        stdin.echoMode = false; 
        print("\n  To return in main lobby press Enter");
        stdin.readLineSync();
        Menu.runMenu(menuTypes.junkDrawer);
    }
}