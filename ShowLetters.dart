import 'dart:math';

class ShowLetters {
    static void run(int length, int countToShow){
        Random rnd = Random();
        int counter = 0;
        String letters = "";
        while(true){
            letters = "";
            for (int j = 0; j < length; j++) {
                letters += String.fromCharCode(97 + rnd.nextInt(26));
            }
            counter++;
            if(letters.contains('fujitoit')) break;
        }
        print("HERE IT IS ${counter} - ${letters}");
        // for (var element in letters) {
        //   print(element);
        // }
    }
}