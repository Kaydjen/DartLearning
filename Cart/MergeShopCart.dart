import 'dart:io';


class MergeShopCart{
    static void merge(){
        Map<String, int> cart = Map();
        String items = element();
        int quantity = numbers();
        cart[items]= quantity;
        print(cart);
    }
}
String element(){
    print('Enter the item to add in the cart');
    String? y;
    y = stdin.readLineSync();
    while(y == null) {
        print('Try again!');
        y = stdin.readLineSync();
    }
    return y;
}

int numbers(){
    print('Enter the quantity of the elements');
    int? x;
    while(true){
    x = int.tryParse(stdin.readLineSync()!);
    if(x == null && x != int) continue;
    else break;
    }
    return x!;
}