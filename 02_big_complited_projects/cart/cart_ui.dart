import 'dart:io';
import '../../00_hub_core/data/menu_massages.dart';
import '../../00_hub_core/menu_system/Menu.dart';
import '../../01_sys/color.dart';
import '../../01_sys/console.dart';
import '../../01_sys/prompt_handler.dart';
import 'cart.dart';

class CartUI{
    static final Map<int, ChoosableOptions> options = {
        1: ChoosableOptions
        ("Show tips", 
        showTips
        ),
        2: ChoosableOptions
        ("View all carts", 
        showAllCarts
        ),
        3: ChoosableOptions
        ("View a cart’s content", 
        showCart
        ),
        4: ChoosableOptions 
        ("Add cart's products", 
        addProducts
        ),
        5: ChoosableOptions
        ("Add new cart", 
        createCart
        ),
        6: ChoosableOptions
        ("Remove a cart", 
        removeCart
        ),
        7: ChoosableOptions
        ("Merge carts", 
        mergeCarts
        ),
        8: ChoosableOptions
        ("Compare two carts", //-
        diff
        ),
        9: ChoosableOptions
        ("Undo last change on a cart", //
        diff
        ),
        10: ChoosableOptions
        ("View history", //-
        showCartsHistory
        ),
        0: ChoosableOptions //-
        ("Main menu", 
        () => Menu.runMenu(menuTypes.main)
        )
    };
    static void mainMenu(){
        Console.clear();
        String? message = "\nEnter option: ";
        for (var optionDescription in options.entries) 
            print("\u001b[38;5;196m${optionDescription.key}.\u001b[38;5;255m ${optionDescription.value.description}");
        //Console.defColor();
        while(true){
            final key = _promptValidateInt(message, countOfLinesToClear: 3);
            if(options.containsKey(key)) {
                options[key]!.onSelected!.call();            
                break;
            }
        }
    }
    static void showTips(){
        Console.clear();
        print("${Color.set(ColorTypes.def)}1. To go to main menu type "
        "${Color.set(ColorTypes.brightCyan, str: "'*'", keepColor: false)} "
        "and press ${Color.set(ColorTypes.brightCyan, str: "Enter", keepColor: false)}");
        _backToMenu();
    }
    /// Displays all carts and their contents in the console.
    static void showAllCarts() {
        Console.clear();
        //Cart.data.forEach((key, value) => print("\u001b[38;5;196m${key}: \u001b[38;5;255m${value}"));
        for (var cart in Cart.data.entries) {
            print("\u001b[38;5;196m${cart.key}:");
            for (var product in cart.value.entries) {
                print("    \u001b[38;5;204m${product.key}: \u001b[38;5;255m${product.value}");
            }
        }
        _backToMenu();
    }
    static void showCart() {
        Console.clear();
        String cartName = _promptValidate("Enter cart name: ");
        while(Cart.data[cartName] == null){
            Console.clearPreviousLines(2);
            cartName = _promptValidate("There is no cart with that name." 
            "\nTry again: ");
        }
        print('');
        Cart.data[cartName]!.forEach((key, value) => print("    \u001b[38;5;204m${key}: \u001b[38;5;255m${value}"));
        print('');

        _backToMenu();
    }
    static void addProducts(){
        Console.clear();
        Console.clearPreviousLines(2);
        print("${Color.grayWhite()}*Press Enter to exit and save\n"); 
        bool isAgain = false;
        String key;
        while(true){
            final text =isAgain ? "${Color.reset()}Try again: " : "${Color.reset()}Enter cart's name: ";
            key = _promptValidate(text);
            if(_wantBackToMainMenu(key)) return;
            if(Cart.data.containsKey(key) && Cart.data[key] != null) break;
            Prompt.invalidInput(errorMessage: "${Color.red()}Cart with the given name doesn't exist", countOfLinesToClear: 3);
            isAgain = true;
        }
        final cart = Cart.data[key]!;
        while(true){
            final keyToProduct = _prompt("\n${Color.grayWhite()}Product name: ");
            if(keyToProduct == null || keyToProduct.isEmpty) break;
            if (cart.containsKey(keyToProduct)) {
                print("\u001b[38;5;252m");
                print("Item already exists with quantity [${cart[keyToProduct]}]."
                      "\nEnter new value to overwrite. "
                      "\n\u001b[38;5;196m'/'\u001b[38;5;252m to abort."
                      "\nPress \u001b[38;5;196mEnter\u001b[38;5;252m to exit and save.");   
                print("\u001b[38;5;255m");
                while (true) {
                  final overwrite = _prompt("${Color.reset()}New quantity: ");
                  if (overwrite == null || overwrite.isEmpty || overwrite == '/') break;
                  if (_updateCartEntry(overwrite, cart, keyToProduct)) break;
                }   
                continue;
            } 
            else{
                cart[keyToProduct] = _promptValidateInt("${Color.grayWhite()}Quantity: ", countOfLinesToClear: 3);
            }
        }
        
        _backToMenu();
    }
    static void createCart() {
        Console.clear();
        final String? cartName = _prompt("\n${Color.reset()}Please, enter cart name: ");
        if (cartName == null || cartName.isEmpty) {
            print("");
            Prompt.invalidInput(countOfLinesToClear: 4);
            return createCart();
        }   
        if (Cart.data.containsKey(cartName)) {
            print("");
            Prompt.invalidInput(errorMessage: "${Color.red()}The cart with this name already exists.");
            return createCart();
        }   
        print(
            "\n${Color.reset()}Now, please, enter items:"
            "\n- Press ${Color.brightCyan()}Enter ${Color.reset()}on empty line to finish"
            "\n- Print ${Color.brightCyan()}'-' ${Color.reset()}to delete previous (not added yet)" // todo: add this shit
        );  
        final Map<String, int> newCart = {};    
        bool shouldEnd = false;
        while (!shouldEnd) {
            final String? product = _prompt("\n${Color.grayWhite()}Product name: ");
            if (product == null || product.isEmpty) break;    
            if (newCart.containsKey(product)) {
                print("${Color.red()}Item already exists with quantity ${Color.brightCyan()}[${newCart[product]}].\n"
                      "${Color.reset()}Enter new value to overwrite, ${Color.brightCyan()}'/' ${Color.reset()}to abort.");   
                while (true) {
                  final String? overwrite = _prompt("${Color.reset()}New quantity: ");
                  if (overwrite == null || overwrite == '/' || overwrite.isEmpty) break;
                  if (_updateCartEntry(overwrite, newCart, product)) break;
                }   
                continue;
            } 
            while (true) {
                final String? quantity = _prompt("${Color.grayWhite()}Product quantity: ");
                if (quantity == null || quantity.isEmpty) {
                    shouldEnd = true;
                    break;
                }
                if(_updateCartEntry(quantity, newCart, product)) break;
            }
        }   
        Cart.addNewCart(cartName, newCart);
        _backToMenu();
    }
    static void removeCart(){
        Console.clear();
        String input;
        do input = _promptValidate("${Color.reset()}Enter cart name to delete it: ");                                             // под чем я это писал... я хочу еще раз попробовать
        while(!Cart.deleteCart(input));        
        print("\n${Color.green()}Cart was successfully deleted");
        _backToMenu();
    }
    static void mergeCarts() {
        while(true){
            Console.clear();
            String sourceCartName1 = _promptValidate("${Color.reset()}First cart to merge: ");
            String sourceCartName2 = _promptValidate("\n${Color.reset()}Second cart to merge: ");
            String newCartName = _promptValidate("\n${Color.reset()}Name of the new merged cart: ");
            if(Cart.mergeCarts(sourceCartName1, sourceCartName2, newCartName)){
                print("\n${Color.green()}Successfully merged");
                break;
            }
            Prompt.invalidInput(errorMessage: "Please, try again");
        }
        print("");
        _backToMenu();
    }
    static void diff(){
        Console.clear();
        (Map<String, int>, Map<String, int>, Map<String, (int, int)>)? changes;
        while(true){
            final originalCartName = _promptValidate("${Color.reset()}Original cart's name: ", countOfLinesToClear: 3);
            final updatedCartName = _promptValidate("${Color.reset()}Updated cart's name: ", countOfLinesToClear: 3);

            changes = Cart.compare(originalCartName, updatedCartName);
            if(changes == null)
                Prompt.invalidInput(errorMessage: "Invalid name, try again.", countOfLinesToClear: 5);
            else break;
        }

        print("");
        print("\u001b[38;5;40mAdded: ");
        for (final addedItems in changes.$1.entries)
            print("     \u001b[38;5;255m${addedItems.key}:\u001b[38;5;46m ${addedItems.value}");

        print("\u001b[38;5;160mRemoved: ");
        for (final removedItems in changes.$2.entries)
            print("     \u001b[38;5;255m${removedItems.key}:\u001b[38;5;196m ${removedItems.value}");

        print("\u001b[38;5;40mChanged: ");
        for (final changedItems in changes.$3.entries)
            print("     \u001b[38;5;255m${changedItems.key}:\u001b[38;5;46m ${changedItems.value.$1} → ${changedItems.value.$2}");
        _backToMenu();
    }
    static void showCartsHistory(){
        Console.clear();
        String? message = 
        "\n${Color.darkRed()}1. ${Color.reset()}Show history of all carts"
        "\n${Color.darkRed()}2. ${Color.reset()}Show history of certain cart"
        "\nEnter option: ";
        int option = _promptValidateInt(message, countOfLinesToClear: 6);
        while(true){
            switch(option){
                case 1: showWholeHistory(); break;
                case 2: 
                    showCertainCartHistory(); 
                    break;
                default: 
                    Prompt.invalidInput(errorMessage: "You option is wrong, try again");
                    continue;
            }
            break;
        }
        _backToMenu();
    }
    static void showCertainCartHistory(){
        Console.clear();
        bool isAgain = false;
        String key;
        while(true){
            key = _promptValidate(isAgain ? "${Color.reset()}Try enter cart's name again: " : "${Color.reset()}Cart's name: ");
            if(Cart.historyData[key] == null) {
                Prompt.invalidInput(errorMessage: "There is no history by this name", countOfLinesToClear: 3);
                isAgain = true;
                continue;
            }
            else break;
        }
        final listOfChanges = Cart.historyData[key]!;
        for (int i = 0; i < listOfChanges.length; i++) {
            print("${Color.set(ColorTypes.brightCyan, str: "${i.toString()}", keepColor: false)}");
            for (var product in listOfChanges[i].entries) {
                print("    \n${Color.set(ColorTypes.brightCyan, str: "${product.key}", keepColor: false)}: ${product.value}");
            }
        }
        _backToMenu();
    }
    static void showWholeHistory(){
        Console.clear();
        if(Cart.historyData.isEmpty) {
            print("${Color.red()}There is no carts' history");
            return;
        }
        for (var certainCartHistory in Cart.historyData.entries) {
            print("${Color.set(ColorTypes.brightCyan, str: "${certainCartHistory.key.toString()}", keepColor: false)}");
            for (int i = 0; i < certainCartHistory.value.length; i++) {
                print("${Color.set(ColorTypes.brightCyan, str: "${i.toString()}", keepColor: false)}");
                for (var product in certainCartHistory.value[i].entries) {
                    print("        \u001b[38;5;207m${product.key}:\u001b[38;5;255m ${product.value}");
                }
            }
        }
        _backToMenu();
    }

    static bool _wantBackToMainMenu(String input){
        if(input.contains("*")){
            mainMenu();
            return true;
        }
        else return false;
    }
    static void _backToMenu(){
        _prompt("${Color.grayWhite()}Press ${Color.brightCyan()}Enter ${Color.grayWhite()}to go to main menu: ");
        mainMenu();
    }
    static String _promptValidate(String message, {int countOfLinesToClear = 3}){
        while (true) {
            String? input = _prompt(message);
            if (input != null && input.trim().isNotEmpty){
                if(input.contains("*")) mainMenu();
                return input;            
            } 
            Prompt.invalidInput(countOfLinesToClear: countOfLinesToClear);
        }
    }
    static int _promptValidateInt(String message, {int countOfLinesToClear = 3}){
        while (true) {
            String? input = _prompt(message);
            if (input != null && input.trim().isNotEmpty) {
                if(input.contains("*")) mainMenu();
                final option = int.tryParse(input);
                if(option != null) return option;
            }           
            Prompt.invalidInput(countOfLinesToClear: countOfLinesToClear);
        }
    }
    static String? _prompt(String message) {
        stdout.write(message);
        stdout.write("\u001b[38;5;196m");
        final input = stdin.readLineSync()?.trim();
        stdout.write("\u001b[38;5;255m");
        return input;
    }
    static bool _updateCartEntry(String inputValueToKey, Map<String, int> cart, String keyToProduct) {
        final int? value = int.tryParse(inputValueToKey);
        if (value == null || value < 0) {
            Prompt.invalidInput(errorMessage: "\nInvalid number. Try again.", countOfLinesToClear: 4);
            return false;
        }
        cart[keyToProduct] = value;
        return true;
    }
}






/*  ver 1


Perfect approach. Let's walk through the **Starter Mini-Challenge** step-by-step with **thorough explanations** and **conceptual examples**, without giving away ready code. The goal is for you to fully understand *what* you're doing and *why*—and solve it on your own.

---

## 🧩 Project: **Mergeable Shopping Cart**

This console-based Dart project teaches you how to:

* Work with `Map<String, int>` (a dictionary-like structure)
* Handle merging data structures
* Compare maps
* Use lists for storing history
* Build undo functionality

---

## ✅ Step 1: **Create and Define Cart Structure**

### What to do:

* Decide how to represent a shopping cart.
* A cart will store item names (as strings) and quantities (as integers).

### Example (conceptual):

Imagine two carts:

* Cart A: contains `"apple": 2` and `"banana": 3`
* Cart B: contains `"banana": 1` and `"orange": 5`

Both carts should be structured as Dart `Map`s.

### What you’ll practice:

* Declaring and using `Map<String, int>`
* Adding entries, updating values
* Iterating through a map

---

## 🔁 Step 2: **Merge Two Carts**

### What to do:

* Implement logic to combine two carts into one.
* If an item appears in both carts, its quantity should be summed.
* If it appears only in one cart, it should just be included as is.

### Example (conceptual):

Merging the above two carts should result in:

* `"apple": 2`, `"banana": 4`, `"orange": 5`

### What you’ll practice:

* Copying maps
* Iterating through key–value pairs
* Using map methods like `containsKey`, `update`, or `putIfAbsent`

---

## 🧮 Step 3: **Compare (Diff) Two Carts**

### What to do:

* Create a function that compares two carts and finds:

  * Items that are **newly added** (exist only in the second cart)
  * Items that are **removed** (exist only in the first cart)
  * Items with **changed quantities** (exist in both, but quantities differ)

### Example (conceptual):

Cart A:

* `"apple": 2`, `"banana": 3`

Cart B:

* `"banana": 5`, `"orange": 1`

**Diff Result**:

* Added: `"orange": 1`
* Removed: `"apple": 2`
* Changed: `"banana": 3 → 5`

### What you’ll practice:

* Comparing keys in two maps
* Finding differences between values
* Creating new maps for reporting differences

---

## 🧠 Step 4: **Track Merge History**

### What to do:

* Before you merge a new cart, save the current cart's state.
* Store previous versions in a list (as copies of the cart).
* This allows "undo" functionality later.

### Example (conceptual):

You start with Cart A, then:

1. Merge Cart B → New state (Cart A1)
2. Merge Cart C → New state (Cart A2)

History list stores:

* \[Cart A, Cart A1]

### What you’ll practice:

* Creating deep copies of maps
* Managing a list of previous states
* Thinking about when to record snapshots

---

## ⏪ Step 5: **Implement Undo**

### What to do:

* Allow the user to undo the last merge.
* This means retrieving the most recent previous cart state from the history list and restoring it.

### Example (conceptual):

Cart A → Merged into A1
Undo → Revert to original Cart A

### What you’ll practice:

* Accessing and removing the last element from a list
* Replacing map contents safely
* Defensive programming (checking if history is empty before undoing)

---

## 🖥️ Step 6: **User Interface in Console**

### What to do:

* Create a menu with simple options like:

  * View current cart
  * Merge another cart
  * Show diff between current and new cart
  * Undo last merge
  * Exit program

Use `stdin.readLineSync()` to read user choices and react accordingly.

### Example (conceptual):

```
Choose an option:
1. View cart
2. Merge another cart
3. Show cart diff
4. Undo last merge
5. Exit
```

### What you’ll practice:

* Console input/output
* Handling user choices
* Writing clean, reusable functions for each action

---

## 🧪 Step 7: **Test Your Program Thoroughly**

### What to do:

* Try merging:

  * A cart with overlapping items
  * A cart with completely different items
  * An empty cart
* Try undoing multiple times
* Try comparing two identical carts

### What you’ll practice:

* Thinking about edge cases
* Building confidence in your solution
* Debugging unexpected behaviors

---

## 🎯 Bonus Challenges (Optional for later)

* Add prices per item and calculate total cost.
* Store items as objects (with `name`, `quantity`, `price`, etc.) instead of just strings and ints.
* Save/load cart history to and from a file using `dart:io`.

---

Let me know when you're ready to begin **Step 1** or if you'd like to recap any of the steps. I can walk you through each individually while keeping everything in your control.



 */

/* ver 2

Of course! Here’s the improved version of the **Starter Mini-Challenge** rewritten as a **clear, structured document**—now including your new ideas like adding/removing carts and enhanced history. It follows the same style as the original plan.

---

## 🛒 Dart Console Project: **Advanced Mergeable Shopping Cart**

### 🎯 Project Goal

Build a Dart console application that allows managing **multiple shopping carts**, each holding a list of items and their quantities. The app supports:

* Adding and removing carts
* Merging carts
* Viewing differences between carts
* Tracking change history per cart
* Undoing changes

---

## ✅ Feature Set Overview (Step-by-Step Tasks)

---

### 🧱 Step 1: **Define the Cart Data Structure**

#### What to do:

* Each cart will store item names (`String`) and quantities (`int`).
* Maintain **multiple carts** in a central storage structure.
* Each cart is identified by a **unique name or ID**.

#### Data structure examples (conceptual):

* A single cart:
  `"cartA" → {"apple": 2, "banana": 3}`
* All carts:
  `Map<String, Map<String, int>>`

#### What you’ll practice:

* Working with nested maps
* Structuring data in scalable ways

---

### ➕ Step 2: **Add and Remove Carts** ⭐️ (*Your enhancement*)

#### What to do:

* Let the user **create a new cart** with a chosen name.
* Let the user **delete an existing cart** by name.
* Validate:

  * No duplicate names when creating
  * Cart must exist to delete it

#### Example (conceptual):

* Add: `"cartHoliday"` → empty cart
* Remove: `"cartA"` → remove from global map

#### What you’ll practice:

* Adding/removing keys from maps
* Input validation and user flow control

---

### 🔁 Step 3: **Merge One Cart Into Another**

#### What to do:

* Allow the user to select two existing carts:

  * **Source cart**: data that will be added
  * **Target cart**: will receive merged contents
* Items with matching names: sum their quantities
* Items only in source: add them to target
* Before merging, save a **copy of the target cart** to its history (see Step 5)

#### What you’ll practice:

* Iterating and merging map data
* Safe data mutation
* Working with nested structures

---

### 📉 Step 4: **Compare Two Carts (Diff Viewer)**

#### What to do:

* Let the user pick any two carts to compare
* Identify:

  * Items **added**
  * Items **removed**
  * Items with **changed quantities**
* Display the results clearly

#### Example (conceptual):

Cart A:

```dart
{"apple": 2, "banana": 3}
```

Cart B:

```dart
{"banana": 5, "orange": 1}
```

Diff:

* Added: `"orange"`
* Removed: `"apple"`
* Changed: `"banana" → 3 → 5"`

#### What you’ll practice:

* Comparing map keys and values
* Building a difference report

---

### 📚 Step 5: **Implement Per-Cart Change History** ⭐️ (*Your enhancement*)

#### What to do:

* Every cart gets its own history list:

  ```dart
  Map<String, List<Map<String, int>>>
  ```
* Before each destructive action (e.g. merge or delete), **push a snapshot** of the cart to its history
* Allow optional viewing of this history (e.g., with version numbers or timestamps)

#### What you’ll practice:

* Working with nested data: list of maps inside a map
* Designing rollback-friendly systems

---

### ⏪ Step 6: **Undo Last Change for a Cart**

#### What to do:

* Let user pick a cart and undo the most recent change
* If the cart’s history has previous versions, restore the last one
* If no history is available, show a friendly message

#### What you’ll practice:

* Safe rollback logic
* Guarding against errors like empty lists
* State restoration

---

### 🖥️ Step 7: **Create a Console Menu Interface**

#### What to do:

Create a clean looped menu to let the user choose:

```
1. View all carts
2. Add new cart
3. Remove a cart
4. View a cart’s content
5. Merge carts
6. Compare two carts
7. Undo last change on a cart
8. View cart history
9. Exit
```

Use `stdin.readLineSync()` to receive input and match it to functions.

#### What you’ll practice:

* Writing user input logic
* Building interactive console UIs
* Handling invalid inputs

---

## 🧪 Step 8: **Test Your Application**

#### What to do:

Manually test the app by:

* Creating and deleting carts
* Merging with various overlap patterns
* Undoing merges
* Comparing identical or empty carts
* Viewing histories

#### What you’ll practice:

* Manual testing flow
* Thinking like a user
* Debugging logic issues

---

## 🚀 Bonus Challenges (For After Core Features)

* Add item **price** and **category**
* Allow editing specific items (change quantity or remove it)
* Automatically generate sample carts for testing
* Save/load all data from files (using JSON)
* Track cart metadata like last updated time or owner

---

## 🧭 Execution Plan

| Step | Description                    | Your Goal                      |
| ---- | ------------------------------ | ------------------------------ |
| 1    | Build core cart data structure | Set up the central storage     |
| 2    | Add/remove carts               | Build basic cart management    |
| 3    | Merge carts                    | Practice map merging logic     |
| 4    | Show differences between carts | Build a diff comparison tool   |
| 5    | History per cart               | Store versions of carts safely |
| 6    | Undo system                    | Enable rollback functionality  |
| 7    | User interface                 | Make it interactive            |
| 8    | Manual testing                 | Test all flows and bugs        |

---

Would you like to begin now with **Step 1: Building the cart structure and central storage**? I can walk you through what to implement and what to think about before coding.


 */



/*     //ShowLetters.run(8, 2147483646);
    CartUI.showAllCarts();
    print("");
    Cart.addNewCart("New Cart", {"Invalid": 1});
    CartUI.showAllCarts();
    print("");
    Cart.tryAddProducts("New Cart", {"Invalid":1 });
    CartUI.showAllCarts();
    print("");
    print("");
    Cart.mergeCarts(
        "Cart Kaydjen", 
        "Cart Fuad",
        "Our Cart",
        doRemovePreviousCarts: false);
    CartUI.showAllCarts();

    print("");
    Cart.compare("Cart Kaydjen", "Our Cart");
    CartUI.createCart();
    CartUI.showAllCarts(); */

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


