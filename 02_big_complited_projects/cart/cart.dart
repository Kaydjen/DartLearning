import '../../01_sys/Console.dart';

class Cart{
    static Map<String, Map<String, int>> _carts = {
        "Cart Dart": {
            "Manual": 1,
            "Documentation": 2,
        },
        "Cart Kaydjen": {
            "Irish Coffee": 10,
            //"Artificial Backwardness": 0, // (
            //"Programmers' Ramen (RAM-en)": 1,
            "RAM-en": 1,
            "Carrot": 999,
            "404: Item Not Found": 999
        },
        "Cart Fuad": {
            "Errors": 999,
            "Programmers' Ramen (RAM-en)": 2,
        },
        "Old": {
            "Potato": 20,
            "RAM-en": 666,
            "Carrot": 1,
            "404: Item Not Found": 1000
        },
    }; //"Brain": 0, // XD
    static Map<String, Map<String, int>> get data => _carts;
    static Map<String, List<Map<String, int>>> _historyData = Map();
    static Map<String, List<Map<String, int>>> get historyData => _historyData;
    /// Adds a new cart to the data. 
    /// 
    /// If a cart with this name `[cartName]` already exists, 
    /// it will overwrite
    /// only if `[doRewriteIfExists]` is `true` (default: `true`)
    static void addNewCart(String cartName, Map<String, int> productQuantities, [bool doRewriteIfExists = true]){
        // Add or update cart if not exists or overwrite allowed
        if (!_carts.containsKey(cartName) || doRewriteIfExists) 
            _carts[cartName] = productQuantities; // Set new cart value or create it
        saveCartSnapshot(cartName, productQuantities);
    }
    /// Tries to add product quantities to an existing cart
    /// 
    /// Returns `true` if the cart exists and products were added
    /// 
    /// Returns `false` if the cart does not exist
    static bool tryAddProducts(String cartName, Map<String, int> productQuantities){ // так, чет я смотрю сейчас на этот код, и понимаю, что: "Оно нам нахуй не нужон". Чет я не особо догнал логику того, зачем я это написал. Так что - разбирайся сам
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
                return previousValue;
            }
        );
        saveCartSnapshot(cartName, productQuantities);
        return true; // Products added successfully
    }
    /// Merges two existing carts into a new one with name [mergedCartName]
    /// 
    /// The merged cart will contain combined products from both carts.
    /// If [doRemovePreviousCarts] is true - the original carts will be removed.
    /// If [mergedCartName] already exists, merge wont be performed.
    static bool mergeCarts(String firstCartName, String secondCartName, String mergedCartName, {bool doRemovePreviousCarts = true}){
        final firstCart = _carts[firstCartName];
        final secondCart = _carts[secondCartName];
        // Check if both carts exist - abort if not
        if(firstCart == null || secondCart == null){
            print("One of the carts doesn't exist"); // todo - complited: handle this case  /// this way of compliting is like shit, but I dont mind
            return false;
        }
        // if cart with name [mergedCartName] already exists - abort the method
        if(_carts[mergedCartName] != null){
            print("The map with this name already exists");
            return false;
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

        saveCartSnapshot(firstCartName, firstCart);
        saveCartSnapshot(secondCartName, secondCart);
        saveCartSnapshot(mergedCartName, _carts[mergedCartName]!);
        // Remove original carts after merge if neccessery
        if(doRemovePreviousCarts){
            _carts.remove(firstCartName);
            _carts.remove(secondCartName);
        }
        return true;
    }
    static (Map<String, int>, Map<String, int>, Map<String, (int, int)>)? compare(String previousCart, String currentCart) {
        final prev = _carts[previousCart];
        final curr = _carts[currentCart];

        if (prev == null || curr == null) return null; 

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
    static void saveCartSnapshot(String cartName, Map<String, int> productQuantities){
        // if(_carts[cartName] == null){
        //     print("Invalid, cart history can't be edited - cart doesn't exist");
        //     return;
        // }
        if(_historyData[cartName] == null)
            _historyData[cartName] = [];
        _historyData[cartName]!.add(productQuantities);
    }
    static bool deleteCart(String cartName){
        if(_carts[cartName] == null){
            Console.invalidInput(errorMessage: "\nCan't delte, because cart doesn't exist or name differ", countOfLinesToClear: 4);
            return false;
        }
        _carts.remove(cartName);
        saveCartSnapshot(cartName, Map());
         return true;
    }
}
