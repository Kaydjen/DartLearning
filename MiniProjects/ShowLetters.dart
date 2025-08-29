import 'dart:math';

class ShowLetters{
    static void show(){
        while (true){
        List<String> letters = [];
        for(int i = 0; i < 8; i++){
            Random a = Random();
            int c = a.nextInt(26);
            String letter = String.fromCharCode((c + 65));
            letters.add(letter);
        }
        print(letters);
        }
    }
}