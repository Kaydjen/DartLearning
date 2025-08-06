
import 'dart:io';
import 'sys/Console.dart';

class Cart{
    static Map<String, Map<String, int>> _carts = {
        "Cart Dart": {
            "Manual": 1,
            "Documentation": 2,
        },
        "Cart Kaydjen": {
            //"Irish Coffee": 10,
            //"Potato": 20,
            //"Artificial Backwardness": 0, // (
            "Programmers' Ramen (RAM-en)": 1,
            "Invalid": 999,
            //"404: Item Not Found": 999
        },
        "Cart Fuad": {
            "Errors": 999,
            "Programmers' Ramen (RAM-en)": 2,
        },
    }; //"Brain": 0, // XD
    static Map<String, Map<String, int>> get data => _carts;

    /// Adds a new cart to the data. 
/// 
/// If a cart with this name `[cartName]` already exists, 
/// it will overwrite
/// only if `[doRewriteIfExists]` is `true` (default: `true`)
    static void addNewCart(String cartName, Map<String, int> productQuantities, [bool doRewriteIfExists = true]){
    // Add or update cart if not exists or overwrite allowed
    if (!_carts.containsKey(cartName) || doRewriteIfExists) 
        _carts[cartName] = productQuantities; // Set new cart value or create it
}
    /// Tries to add product quantities to an existing cart
/// 
/// Returns `true` if the cart exists and products were added
/// 
/// Returns `false` if the cart does not exist
    static bool tryAddProducts(String cartName, Map<String, int> productQuantities){
    // Check if cart exists
    if(!_carts.containsKey(cartName)) {
        print("The cart with this name doesn't exist");
        return false; // Abort if cart not found
    }

    // Update existing cart with new product quantities
    _carts.update(cartName, 
        (previousValue) {
            // Loop through current cart items (soon - previous items)
            previousValue.forEach((key, value){
                // If same product exists in input, increase quantity
                if(productQuantities.containsKey(key)){
                    previousValue[key] = previousValue[key]! + value;
                }
            });
            return previousValue; // Return updated map after values were updated
        }
    );
    return true; // Products added successfully
}
    /// Merges two existing carts into a new one with name [mergedCartName]
/// 
/// The merged cart will contain combined products from both carts.
/// If [doRemovePreviousCarts] is true - the original carts will be removed.
/// If [mergedCartName] already exists, merge wont be performed.
    static void mergeCarts(String firstCartName, String secondCartName, String mergedCartName, {bool doRemovePreviousCarts = true}){
    final firstCart = _carts[firstCartName];
    final secondCart = _carts[secondCartName];
    // Check if both carts exist - abort if not
    if(firstCart == null || secondCart == null){
        print("One of the carts doesn't exist"); // todo: handle this case
        return;
    }
    // if cart with name [mergedCartName] already exists - abort the method
    if(_carts[mergedCartName] != null){
        print("The map with this name already exists");
        return;
    } // otherwise create new cart with data from first cart
    else{
        _carts[mergedCartName] = Map();
        _carts[mergedCartName]!.addAll(firstCart);
    }

    // Merge data from second cart into new cart
    _carts.update(mergedCartName, (newValue){
        // For each product in second cart
        secondCart.forEach((key, value){
            // Add to existing or insert new product
            newValue.update(key, (old) => old + value, ifAbsent: () => value);
        });
        return newValue; // Return updated cart
    });

    // Remove original carts after merge if neccessery
    if(doRemovePreviousCarts){
        _carts.remove(firstCartName);
        _carts.remove(secondCartName);
    }
}
    static void compare(String previousCart, String currentCart){
        final changes = _compare(previousCart, currentCart);
        if(changes == null){
            print("No changes");
            return;
        }

        print("Added: ");
        for (final addedItems in changes.$1.entries)
            print("     ${addedItems.key}: ${addedItems.value}");

        print("Removed: ");
        for (final removedItems in changes.$2.entries)
            print("     ${removedItems.key}: ${removedItems.value}");

        print("Changed: ");
        for (final changedItems in changes.$3.entries)
            print("     ${changedItems.key}: ${changedItems.value.$1} → ${changedItems.value.$2}");
    }
    static (Map<String, int>, Map<String, int>, Map<String, (int, int)>)? _compare(String previousCart, String currentCart) {
        final prev = _carts[previousCart];
        final curr = _carts[currentCart];

        if (prev == null || curr == null) {
            print("One of the carts doesn't exist");
            return null; 
        }

        final addedItems = _getCartDifference(curr, prev);
        final removedItems = _getCartDifference(prev, curr);
        final changedItems = <String, (int, int)>{};

        for (var currEntry in curr.entries) {
            final key = currEntry.key;
            if(prev.containsKey(key)) 
                changedItems[key] = (prev[key]!, currEntry.value);
        }
        return (addedItems, removedItems, changedItems);
    }
    static Map<String, int> _getCartDifference( Map<String, int> baseCart, Map<String, int> cartToExclude) {
        Map<String, int> result = {};
        baseCart.forEach((key, value) {
            if (!cartToExclude.containsKey(key)) result[key] = value;
        });
        return result;
    }
}

class CartUI{
    /// Displays all carts and their contents in the console.
    static void showAllCarts() =>
        Cart.data.forEach((key, value) => print("${key}: ${value}"));
    static void createCart(){
        stdout.write("\nPlease, enter cart name: ");
        String? input = stdin.readLineSync();
        if(input == null || input.compareTo('') == 0){
            Console.invalidInput(countOfLinesToClear: 3);
            createCart();
            return;
        }
        if(Cart.data.containsKey(input)){
            Console.invalidInput(errorMessage: "The card with this name already exists");
            createCart();
            return;
        }
        stdout.write("\nNow, please, enter items (To end writing just press enter on empty line, to delete previous print simbol '-' and press enter): ");
        String cartName = input;
        Map<String, int> newCart = Map();
        bool canContinue;
        while(true){
            stdout.write("\nProduct name: ");
            (input, canContinue) = checkInput();
            if(!canContinue) break;
            String key = input!;
            bool isAgain = false;
            if(newCart.containsKey(key))
            {
                print("This item already exists, so its value [${newCart[key]}] can be overwritten, print value to ovewrite and continue, print '/' if you want to abort, to end writing press enter on empty line");
                do{
                    (input, canContinue) = checkInput();
                    if(!canContinue) break;
                    if(input!.compareTo('/') == 0) continue;
                    if(doAgain(input, newCart, key)) isAgain = true;
                    else isAgain = false;
                }while(isAgain);
                continue;
            } 
            isAgain = false;
            stdout.write("\nProduct quantity: ");
            do{
                (input, canContinue) = checkInput();
                if(!canContinue) break;
                if(doAgain(input!, newCart, key)) isAgain = true;
                else isAgain = false;
            }while(isAgain);
        }

        Cart.addNewCart(cartName, newCart);
    }

    static (String?, bool) checkInput(){
        bool canContinue = true;
        String? input = stdin.readLineSync();
        if(input != null && input.compareTo('') == 0) canContinue = false;
        if(input!.compareTo('-') == 0){

        }
        return (input, canContinue);
    }
    static bool doAgain(String input, Map<String, int> cart, String key){
        int? parsedInput = int.tryParse(input);
        if(parsedInput == null)
        {
            print("Please, enter valid quantity");
            return true;
        }
        else{
            cart[key] = parsedInput;
            return false;
        } 
    }

}

/* 



    static void mergeCarts(String firstCartName, String secondCartName, String mergedCartName){
        if(!_carts.containsKey(firstCartName) || !_carts.containsKey(secondCartName)){
            print("One of the carts doesn't exist"); // todo: came up what to do in that case
            return;
        }
        if(_carts.putIfAbsent(mergedCartName, () => _carts[firstCartName]!) != _carts[firstCartName]) {
            print("The map with this name already exists"); // todo: write respond on this situation
            return;
        }
    
        _carts.update(mergedCartName, (newValue){
            _carts[secondCartName]!.forEach((key, value){
                /// three ways:
                newValue.update(key, (old) => old + value, ifAbsent: () => value);
                
                if(newValue.containsKey(key)) newValue[key] = newValue[key]! + value;
                else newValue[key] = value;

                newValue[key] = newValue.containsKey(key) ? newValue[key]! + value : value;
                ///
            });
        });
    }


//=====================
// three ways of writing the same shit

        if (!_carts.containsKey(cartName)) 
            _carts[cartName] = productQuantities; // if the cart doesn't exist - add it, if added syccessfully - end method
        else if(doRewriteIfExists)
            _carts[cartName] = productQuantities; 
//---------------------
        _carts[cartName] = (!_carts.containsKey(cartName) || doRewriteIfExists) ? productQuantities : _carts[cartName]!; 
//---------------------
         if (!_carts.containsKey(cartName) || doRewriteIfExists) 
            _carts[cartName] = productQuantities;

//=====================
    static void addOrUpdateCart(String cartName, Map<String, int> productQuantities, [bool doRewrite = true]){
        if(!putIfAbsent(cartName, productQuantities)) 
            if(doRewrite) _carts[cartName] = productQuantities;  
    }
    static bool putIfAbsent(String cartName, Map<String, int> productQuantities) =>
       (_carts.putIfAbsent(cartName, () => productQuantities) == productQuantities);

 */