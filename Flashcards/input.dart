import 'dart:io';
import 'flashcard.dart';
import 'reviel.dart';
class Input{
    static void userInput(){
        //print(ShowOff.paine.question);
        var a;
        while(a == null) a = stdin.readLineSync();
        //print(ShowOff.paine.answer);
        print('Hit me up with the score you got on a scale from 0 to 5 where:');
        print('0 - absolutley nothing');
        print('1 - almost nothing');
        print('2 - had to cheat to answe this one');
        print('3 - it was a REAl strugle');
        print('4 - I was kind of sure');
        print('5 - just nailed it flawlessly');
        String? scoreString = '';
        while(scoreString == '' || scoreString == null) scoreString = stdin.readLineSync();
        int? scoreInt = int.tryParse(scoreString);
        while(scoreInt == null || (scoreInt < 0 && scoreInt > 5)){ 
        while(scoreString == '' || scoreString == null) scoreString = stdin.readLineSync();
        scoreInt = int.tryParse(scoreString);
        };
        //ShowOff.paine.update(scoreInt);
        //print(ShowOff.paine.easeFactor);
    }
    static (String, String) asigning(){
        String? question;
        while (question == null) question = stdin.readLineSync();
        String? answer;
        while(answer == null) answer = stdin.readLineSync();
        return (question, answer);  
    }
}