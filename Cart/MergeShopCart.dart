import 'dart:io';

class MergeShopCart {
    static Map<String, Map<String, int>> Carts = {
"CartA": {"apple": 2, "banana": 3, "ramen": 666, "errors" : 404, "invalid": 2},
"CartB": {"banana": 2, "orange": 1, "errors": 321, "Errors": 1}
};
    
    static void merge() {
        print('Choose an option for your next move' '\n1 - Add a new Cart\n2 - Remove an existing Cart\n3 - You can see the exact  Cart\n4 - You can Add some products\n5 - You can Merge two Carts\n6 - You can compare two Carts');
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
        else if(b == 5) merging();
        else if(b == 6) comparing();
        else if(b == 7) smotret();
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
                String? e = stdin.readLineSync();
                if(e == null) {
                    addingPorducts();
                    return;
                }
                if(Carts[d]!.containsKey(e)){
                    print('Introduce the quantity of the existen product');
                    int? x = int.tryParse(stdin.readLineSync()!);
                if(x == null) {
                    addingPorducts();
                    return;
                }
                    Carts[d]?[e] = x;
                }
                else{ 
                print('Introduce the quantity of the product');
                int? x = int.tryParse(stdin.readLineSync()!);
                if(x == null) {
                    addingPorducts();
                    return;
                }
                Carts[d]?[e] = x;
                }
            }
            else {
                print('Please, try again');
                addingPorducts();
            }
        }

        static void merging(){
            print('Here is the merging, type the name of the merged cart(beside the word Cart)');
            String? d = stdin.readLineSync();
            if(d == null){
                merging();
                return;
            }
            d = 'Cart' + d;
            if(Carts.containsKey(d)){
                print('This cart already exists');
                sleep(Duration(seconds: 1));
                print('Do you want to rewrite(a) already existing products or choose another cart(b)?');
                print('a/b');
                String? z = stdin.readLineSync();
                if(z == 'a') optionA(d);
                else merging();
            }
            else Carts[d] = Map();
            print('Write the first Cart name(beside the word Cart)');
            String? CartA = stdin.readLineSync();
            if(CartA == null){
             optionA(d);
                return;
            }
            CartA = 'Cart' + CartA;
            print('Write the second Cart name(beside the word Cart)');
            String? CartB = stdin.readLineSync();
            if(CartB == null){
                optionA(d);
                return;
            }
            CartB = 'Cart' + CartB;
            if(Carts.containsKey(CartA) && Carts[CartA] != null)
            Carts[d]!.addAll(Carts[CartA]!);
            Carts[CartB]!.forEach((key, value) {
                Carts[d]![key] = (Carts[d]![key] ?? 0) + value;
            });
        }

        static void optionA(String d){
        Carts.remove(d);
        Carts[d] = Map();
        print('Write the first Cart name(beside the word Cart)');
        String? CartA = stdin.readLineSync();
        if(CartA == null){
            optionA(d);
            return;
        }
        CartA = 'Cart' + CartA;
        print('Write the second Cart name(beside the word Cart)');
        String? CartB = stdin.readLineSync();
        if(CartB == null){
            optionA(d);
            return;
        }
        CartB = 'Cart' + CartB;
        if(Carts.containsKey(CartA) && Carts[CartA] != null)
        Carts[d]!.addAll(Carts[CartA]!);
        Carts[CartB]!.forEach((key, value) {
            Carts[d]![key] = (Carts[d]![key] ?? 0) + value;
        });
        }
        static void comparing(){
            print('Here you can compare two different carts');
            List<String> ComAdded = [];
            List<String> ComDeleted = [];
            List<String> ComEdited = [];
            print('Please, write the name of the first Cart(beside the word Cart)');
            String? var1 = stdin.readLineSync();
            if(var1 == null){
                comparing();
                return;
            }
            var1 = 'Cart' + var1;
            if(!Carts.containsKey(var1)){
                comparing();
                return;
            }
            print('Please, write the name of the second Cart(Beside the word Cart)');
            String? var2 = stdin.readLineSync();
            if(var2 == null){
                comparing();
                return;
            }
            var2 = 'Cart' + var2;
            if(!Carts.containsKey(var2)){
                comparing();
                return;
            }
            for (var entry in Carts[var1]!.entries) {
              if(Carts[var2]!.containsKey(entry.key)) ComAdded.add(entry.key);
              else ComDeleted.add(entry.key);
            }
            for (var entry in Carts[var2]!.entries) {
              if(!Carts[var1]!.containsKey(entry.key)) ComEdited.add(entry.key);
            }
            print(ComAdded);
            print(ComDeleted);
            print(ComEdited);
        }
        static void smotret(){
            print(Carts);
        }
}

