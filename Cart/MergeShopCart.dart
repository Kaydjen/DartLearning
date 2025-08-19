import 'dart:io';

class MergeShopCart {
    static Map<String, Map<String, int>> Carts = {
"CartA": {"apple": 2, "banana": 3},
"CartB": {"orange": 1}
};
    
    static void merge() {
        print('Choose an option for your next move' '\n1,2');
        String? a = stdin.readLineSync();
        if(a == null){
            merge();
            return;
        }
        int? b = int.tryParse(a);
        if(b == null){
            merge();
            return;
        }
        if(b == 1) option_1();
        else print('Have a good day');
        sleep(Duration(seconds: 2));
        print("\x1B[2J\x1B[0;0H");
        String? c = again();
        if(c == 'y'){
            merge();
            return;
        }
        else return;
    }
    static void option_1(){
        print('You can add a cart here');
        print('Plase, write a name after the word Cart');
        String? d = stdin.readLineSync();
        if (d == null){
            option_1();
            return;
        }
        d = 'Cart' + d;
        if(Carts.containsKey(d)){
            print('This cart already exists, please, retry');
            sleep(Duration(seconds: 1));
            print("\x1B[2J\x1B[0;0H");
            stdout.write('\x1B[1A'); 
            stdout.write('\x1B[0G');
            option_1();
            return;
        }
        Carts[d] = Map();
        print(Carts);

    }

        static String again(){
        stdout.write('\x1B[1A');
        stdout.write('\x1B[0G');
        print('Would you like to continue?\ntype y if it\'s so and n if it\'s no');
        print('y/n');
        String? c = stdin.readLineSync();
        if (c == null){
            again();
            return '';
        }
        print("\x1B[2J\x1B[0;0H");
        stdout.write('\x1B[1A'); 
        stdout.write('\x1B[0G');
        return c;
        }
}

