/* 

### 1. Word Frequency Counter

Problem: Given a string, return a map of each word and how many times it appears.
Skills: Map<String, int>, splitting strings, loop logic.

> 💡 *"the cat and the dog and the mouse"*
> 👉 {the: 2, cat: 1, and: 2, dog: 1, mouse: 1}

 */

import 'dart:io';

import 'sys/Console.dart';

class WordFrequency{
    static void run(){
        Console.clear();
        Console.defColor();
        Console.placeCursor(14);
        stdin.echoMode = true; 

        print("  Please, enter text\n");
        Map<String, int> txt = Map();
        String? text = stdin.readLineSync();
        if(text == null){
            Console.invalidInput("Please, enter a proper text");
            run();
            return;
        }
        List<String> newText = text.toLowerCase().replaceAll(new RegExp(r'[^\w\s]+'),'').split(' ');

        newText.forEach((el) {
            if(txt.containsKey(el)) txt[el] = txt[el]! + 1;
            else txt.putIfAbsent(el, () => 1);
        });
        for (var word in txt.keys) 
            print("    ${word}: ${txt[word]}");

        stdin.echoMode = false; 
        print("\n  To return in main lobby press Enter");
        String? input = stdin.readLineSync();
        Console.grayColor();
    }
}