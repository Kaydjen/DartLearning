import 'dart:io';
import 'dart:convert';
import 'color.dart';
import 'console.dart';
import 'exceptions/console_exeptions/string_exceptions.dart';
import 'exceptions/result_handler.dart';

class Prompt {
    /// It prints one single line in the middle of current console line
    static void printOneLn(String message){
        int rows = ((Console.width - visibleLength(message))/2).round();
        print(' ' * rows + message);
    }
    static void printLns(List<String> list){
        
    }
    static int visibleLength(String input) => input.replaceAll(RegExp(r'\x1B\[[0-9;]*[a-zA-Z]'), '').length;
    static void invalidInput({String errorMessage = "Please, enter proper input value ", String tipMessage = "",  int countOfLinesToClear = 3}){ // todo: polish of
        stdout.write(Color.set(ColorTypes.red, str: "$errorMessage ${Color.grayWhite}\nRestarting"));
        for (var i = 0; i < 3; i++) {
            stdout.write('${Color.grayWhite}.');
            sleep(Duration(milliseconds: 750));
        }
        sleep(Duration(milliseconds: 100));
        Console.clearPreviousLines(countOfLinesToClear);
    }
    static String validate(String message, {int countOfLinesToClear = 3, Function(String) onStringCheck = _func}){
        while (true) {
            String? input = prompt(message);
            if (input != null && input.isNotEmpty) {
                onStringCheck(input);
                return input;
            }            
            invalidInput(countOfLinesToClear: countOfLinesToClear);
        }
    }
    static double validateIntDouble(String message, {int countOfLinesToClear = 3, Function(String) onStringCheck = _func}){
        while (true) {
            final input = prompt(message);
            if (input != null && input.isNotEmpty) {
                onStringCheck(input);
                final option = double.tryParse(input);
                if(option != null) return option;
            }           
            invalidInput(countOfLinesToClear: countOfLinesToClear);
        }
    }

    static void _func(String input){
        
    }
    static String? prompt(String message) {
        stdout.write(message);
        stdout.write("\u001b[38;5;196m");
        final input = stdin.readLineSync(encoding: utf8)?.trim();
        stdout.write("\u001b[38;5;255m");
        return input;
    }
    /// Returns flags
    static Result<Map<String, String>> getFlagsFromStr(String str, {String prefix = "--"}){
        if(!str.contains(prefix)) return Result.fail(NoPrefixFound(str, prefix));
        List<String> res = List.empty(growable: true); // from: "4 --key1 value1 -- key2   value2"  to -> [key1 value1, key2   value2]
        List<int> indexes = List.empty(growable: true); // identify idexes of prefixes (index of first prefix above is 2)
        int idex = 0;
        do{ // get indexes of all prefixes
            indexes.add(str.indexOf(prefix, (idex > 0 ? indexes[idex-1]+2 : 0)));
            idex++;
        }while(str.contains(prefix, indexes[idex-1]+1));
        idex = 0;
        do{ // get result list
            res.add(str.substring(indexes[idex]+prefix.length, (indexes.length <= idex+1 ? str.length : indexes[idex+1])).trim());
            idex++;
        }while(idex < indexes.length);

        Map<String, String> map = Map(); // key-value pairs obtained from [key1 value1, key2   value2]
        for (var str in res) {
            if(!str.contains(" ")) break;
            final idex = str.indexOf(" ");
            map[str.substring(0, idex)] = str.substring(idex).trim();
        }
        if(map.isEmpty) return Result.fail(FlagsNotFound(str, prefix));
        else return Result.ok(map);
    }

    /* old, just save it, might come in handy 
    
        static Result<List<String>> getStrList(String str, {String prefix = "--"}){
        if(!str.contains(prefix)) return Result.fail(NoPrefixFound(str, prefix));
        List<String> res = List.empty(growable: true);
        List<int> indexes = List.empty(growable: true);
        int idex = 0;
        do{
            indexes.add(str.indexOf(prefix, (idex > 0 ? indexes[idex-1]+2 : 0)));
            idex++;
        }while(str.contains(prefix, indexes[idex-1]+1));
        idex = 0;
        do{
            res.add(str.substring(indexes[idex]+2, (indexes.length <= idex+1 ? str.length : indexes[idex+1])).trim());
            idex++;
        }while(idex < indexes.length);
        return Result.ok(res);
    }
     */
}