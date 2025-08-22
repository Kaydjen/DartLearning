import 'dart:io';

class MergeShopCart {
    static Map<String, Map<String, int>> Carts = {
"CartA": {"apple": 2, "banana": 3},
"CartB": {"orange": 1}
};
    
    static void merge() {
        print('Choose an option for your next move' '\n1,2,3,4,5');
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
        if(b == 1) adding();
        else if(b == 2) removing();
        else if(b == 3) seeing();
        else if(b == 4) addingPorducts();
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
    static void adding(){
        print('You can add a cart here');
        print('Plase, write a name after the word Cart');
        String? d = stdin.readLineSync();
        if (d == null){
            adding();
            return;
        }
        d = 'Cart' + d;
        if(Carts.containsKey(d)){
            print('This cart already exists, please, retry');
            sleep(Duration(seconds: 1));
            print("\x1B[2J\x1B[0;0H");
            stdout.write('\x1B[1A'); 
            stdout.write('\x1B[0G');
            adding();
            return;
        }
        Carts[d] = Map();
        print(Carts);

    }

        static void removing(){
            print('You can remove a cart here');
            print('Please, write the name of the cart(beside the word Cart itself)');
            String? d = stdin.readLineSync();
            if(d == null) {
                removing();
                return;
            }
            d = 'Cart' + d;
            if(Carts.containsKey(d)){
                Carts.remove(d);
                print('The cart has been deleted succesfully');
            }
            else{
                print('There is no such a cart, please retry');
                sleep(Duration(seconds: 1));
                print("\x1B[2J\x1B[0;0H");
                stdout.write('\x1B[1A'); 
                stdout.write('\x1B[0G');
                removing();
                return;
            }
        }

        static void seeing(){
            print('Here you can see the specific cart');
            print('Write the name of the Cart(beside the word Cart itself)');
            String? d = stdin.readLineSync();
            if(d == null) {
                seeing();
                return;
            }
            d = 'Cart' + d;
            if(Carts.containsKey(d)){
                if(Carts[d]!.isEmpty) print('There is nothing in this cart');
                else print(Carts[d]);
            }
            else {
                print('Something went wrong, please, try one more time!');
                sleep(Duration(seconds: 1));
                print("\x1B[2J\x1B[0;0H");
                stdout.write('\x1B[1A'); 
                stdout.write('\x1B[0G');
                seeing();
                return;
            }
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

        static void addingPorducts(){
            print("Please, introduce the name of the cart you want to edit(beside the word Cart)");
             String? d = stdin.readLineSync();
            if(d == null) {
                addingPorducts();
                return;
            }
            d = 'Cart' + d;
            if(Carts.containsKey(d)){
                print('Introduce the product');
                String e = stdin.readLineSync()!;
                if(e == null) addingPorducts();
                print('Introduce the quantity of the product');
                int x = int.tryParse(stdin.readLineSync()!)!;
                if(x == null) addingPorducts();
                Carts[d]?[e] = x;
            }
            else {
                print('Please, try again');
                addingPorducts();
            }
        }
}

