import 'dart:io';
import 'dart:math';

class ShowLetters{
    static void show(){
        for(int j = 0; j < 3; j++){
        List<String> letters = [];
        for(int i = 0; i < 3; i++){
            Random a = Random();
            int c = a.nextInt(26);
            String letter = String.fromCharCode((c + 65));
            letters.add(letter);
        }
        print(letters);
        }
    }
}