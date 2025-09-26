import 'dart:io';
import 'dart:convert';
import '../../01_sys/cli.dart';
import '../../01_sys/color.dart';
import '../../01_sys/console.dart';
import '../../01_sys/prompt_handler.dart';
import 'sm2.dart';
import 'sm2_ui.dart';

class SM2UIValueChanger{
    static final Map<int, CliOptions> options = {
            1: CliOptions(
                des: "to return back",
                opt: ""
            ),
            2: CliOptions(
                des: "to see all flashcards",
                opt: ""
            ),
            3: CliOptions(
                des: "to see certain flashcard",
                opt: "--index_of_card"
            ),
            4: CliOptions(
                des: "to change certain flashcard's ",
                opt: "--index_of_card --question new"
            ),
            // 4: CliOptions(
            //     des: "to change certain flashcard's value (you can write one value or both)",
            //     opt: "--index_of_card --question new_question --answer new_answer"
            // ),
        };

    static void changeValue(){
        Console.clear();
        // for (var el in options.entries) 
        //     Prompt.printOneLn("${Color.grayDark()}Print ${Color.darkRed()}${el.key} ${Color.grayDark()}${el.value}");
        // print("    ");
        Cli.setColumn(options, doFitBC: true);

        return;
        while(true){
            Color.red();
            String? str = stdin.readLineSync(encoding: utf8)?.trim();
            if(str == null){
                _invalidOperation("${Color.red()}Empty line, please, enter proper value");
                break;
            }
            int? strIndex;
            for (int index in options.keys) if(str.startsWith(index.toString())) strIndex = int.tryParse(str[0]);
            if(strIndex == null || !options.containsKey(strIndex)){
                _invalidOperation("${Color.red()}Can't find the index. Please enter the index as mentioned above");
                break;
            }
            if(strIndex > 3 && strIndex < 5){ 
                final res = Prompt.getFlagsFromStr(str);
                if(!res.isSuccess){

                }
                   // Map<String, String> newRes = res.value.entries.where((e) => [if()])
            }
            else{
                switch(strIndex){
                    case 0: 
                        SM2UI.mainMenu();
                        break; 
                    case 1: 
                        _printExamples();
                        break; 
                    case 2:
                        SM2UI.showAllCards();
                        break;
                    case 3:
                        int idex = str.indexOf("--");
                        int lIdex = str.lastIndexOf("--"); // last index of the given pattern
                        str = str.trim();
                        if(idex  < 0 || idex == lIdex) { // just to be sure there is only One prefix
                            // todo: make exception for situations when there is more than one prefix or there is no one
                            continue;
                        }
                        final spaceIdex = str.substring(idex+1).trim().indexOf(" ");
                        if(spaceIdex < 0){ // if there is nothing after index
                            // todo: make exception for situation when there is nothing after index
                            continue;
                        }
                        final cardIdex = int.tryParse(str.substring(idex+1, spaceIdex).trim());
                        if(cardIdex == null){
                            // todo: also make error here, when there is no index after prefix
                            continue;
                        }
                        _showCertainFleshcard(cardIdex);
                        break;
                }
            }
        }
    }
    static void _showCertainFleshcard(int index){
        final res = SM2.tryGetCard(index);
        if(!res.isSuccess) {
            
        }
        SM2UI.printCardContent(res.value!);
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
        Prompt.printOneLn("${Color.darkRed()}4 --1 --question Is it tricky? --answer No");
        Prompt.printOneLn("${Color.grayDark()}Or you can actualy write simplier:");
        Prompt.printOneLn("${Color.darkRed()}4 -1 -q Is it tricky? -a No");
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