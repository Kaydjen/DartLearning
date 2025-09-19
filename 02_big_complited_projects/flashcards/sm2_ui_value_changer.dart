import 'dart:io';
import 'dart:convert';
import '../../01_sys/color.dart';
import '../../01_sys/console.dart';
import '../../01_sys/exceptions/console_exeptions/string_exceptions.dart';
import '../../01_sys/exceptions/result_handler.dart';
import '../../01_sys/prompt_handler.dart';
import 'sm2_ui.dart';

class SM2UIValueChanger{
    static void changeValue(){
        Map<int, String> map = {
            0: "${Color.grayDark()} to return back",
            1: "${Color.grayDark()} to see example",
            2: "${Color.grayDark()} to see all flashcards",
            3: "\"name_of_card\" ${Color.grayDark()} to see certain flashcard",
            4: "${Color.darkRed()}--\"index_of_card\" --question \"new_question\" --answer \"new_answer\""
                "${Color.grayDark()} to change certain flashcard's value (you can write one value or both)",
        };
        for (var el in map.entries) 
            Prompt.printOneLn("${Color.grayDark()}Print ${Color.darkRed()}${el.key} ${el.value}");
        print("    ");

        while(true){
            Color.red();
            String? str = stdin.readLineSync(encoding: utf8)?.trim();
            if(str == null){
                _invalidOperation("${Color.red()}Empty line, please, enter proper value");
                break;
            }
            int? strIndex;
            for (int index in map.keys) if(str.startsWith(index.toString())) strIndex = int.tryParse(str[0]);
            if(strIndex == null || !map.containsKey(strIndex)){
                _invalidOperation("${Color.red()}Can't find the index. Please enter the index as mentioned above");
                break;
            }
            switch(strIndex){
                case 1: 
                    SM2UI.mainMenu();
                    break; 
                case 2: 
                    _printExamples();
                    break; 
            }
        }
    }
    static void _invalidOperation(String reason){
        Prompt.printOneLn(reason);
        for (var i = 0; i < 3; i++) {
            stdout.write('.');
            sleep(Duration(milliseconds: 750));
        }
        Console.clearPreviousLines(1);
    }
    static void _printExamples(){ 
        Prompt.printOneLn("${Color.grayDark()}To change cart's question just print:");
        Prompt.printOneLn("${Color.darkRed()}4 ");
    }
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
            res.add(str.substring(indexes[idex]+2, (indexes.length <= idex+1 ? str.length : indexes[idex+1])).trimRight());
            idex++;
        }while(idex < indexes.length);
        return Result.ok(res);
    }
}


/* 

        Prompt.printOneLn("${Color.grayDark()}Print ${Color.darkRed()} 0 OR * ${Color.grayDark()} to return back");
        Prompt.printOneLn("${Color.grayDark()}Print ${Color.darkRed()} 1 ${Color.grayDark()} to see example");
        Prompt.printOneLn("${Color.grayDark()}Print ${Color.darkRed()} 2 ${Color.grayDark()} to see all flashcards");
        Prompt.printOneLn("${Color.grayDark()}Print ${Color.darkRed()} 3 \"name_of_card\" ${Color.grayDark()} to see certain flashcard");
        Prompt.printOneLn("${Color.grayDark()}Print ${Color.darkRed()}"
        " 4 \"index_of_card\" -question \"new_question\" -answer \"new_answer\""
        "${Color.grayDark()} to change certain flashcard's value (you can write one value or both)");


 */