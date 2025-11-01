import 'dart:io';
import 'dart:math';
import 'cli.dart';
import 'color.dart';
import 'console.dart';
import 'exceptions/console_exeptions/cli_exeptions.dart';
import 'exceptions/result_handler.dart';
import 'prompt_handler.dart';

class CliOptHelper{
    static const CliLineSymbols _sTopUp = CliLineSymbols(crl: "┌", cnl: "┐", hlm: " ", cnml: "┌", cnmr: "┐", hrm: " ", cnr: "┌", crr: "┐");
    static const CliLineSymbols _sTopDown = CliLineSymbols(crl: "└", cnl: "┘", hlm: " ", cnml: "└", cnmr: "┘", hrm: " ", cnr: "└", crr: "┘");
    static const CliLineSymbols _sUp = CliLineSymbols(crl: "┌", cnl: "┬",  cnml: "─", cnmr: "─", cnr: "┬", crr: "┐");
    static const CliLineSymbols _sDown = CliLineSymbols(crl: "└", cnl: "┴",  cnml: "─", cnmr: "─", cnr: "┴", crr: "┘");
    static Result<void> runMenu(Map<int, CliOptions> options){
        final consoleWidth = Console.width;
        final consoleHeight = Console.height;
        while(true){
            Cli.setColumn(options);
            stdout.write(Color.red);
            String input = stdin.readLineSync() ?? "";
            final res = CliOptHelper.processActions(options, input );
            if(!res.isSuccess){
                Prompt.printOneLn(res.error.toString());
                // todo: handle error whan it occurs
                //continue;
            }
            break;
        }
        //Console.setConsoleSize(width: consoleWidth, height: consoleHeight);
        return Result.ok(());
    }
    static Result<void> runTableMenu({String leftStr = "", String rightStr = "", int leftLen = 20, int rightLen = 20, bool isSymmetric = true}){
        // todo: load(save) resolution *(maybe)

        leftLen = max(leftLen, leftStr.length);
        rightLen = max(rightLen, leftStr.length);

        if(isSymmetric) leftLen = rightLen = max(leftLen, rightLen);

        String str = leftStr + "|" + rightStr;

        Map<int, CliOptions> map = {
            0: CliOptions(
                des: str,
            )
        };
        Cli.setColumn(map);

        // todo: unload resolution *(maybe)
        return Result.ok(());
    }

    static Result<void> processActions(Map<int, CliOptions> map, String input){   
        input = input.trim();
        final id = int.tryParse(input.substring(0, 1));
        if(id==null) return Result.fail(IDNotAccessible()); 

        if (!map.containsKey(id) || map[id] == null) return Result.fail(NoSuchId(id)); 
        final cliOptions = map[id]!;

        if(input.length == 1){ // it's for situation when the only thing we wanna make is just get the id and make an action assigned to ID
            final func = cliOptions.func;
            if (func == null) return Result.fail(NoFuncForId(id)); 
            func();
            return Result.ok(());
        }  
        final flagsResult = Prompt.getFlagsFromStr(input, prefix: "-");
        if(!flagsResult.isSuccess) return Result.fail(flagsResult.error!); 
        final newFlags = flagsResult.value!;
        final optFlags = cliOptions.flags;
        if(optFlags == null) return Result.fail(FlagsNotAccessible()); // Expected flags' map in CliOptions, but got undefined
        for (var flag in newFlags.entries) {
            final key = flag.key;
            if(optFlags.containsKey(key)){
                optFlags[key]?.call(flag.value);
            }
        }
        return Result.ok(());
    }
/*     static Result<void> processWithoutId(String input, Map<String, void Function(String value)> map){

    } */
}   



/*
        final int lSL = _length(lStr);
        if((lWidth.isEven && lSL.isEven) || (lWidth.isOdd && lSL.isOdd)){
            final double lwp = (lWidth - lSL)/2;
            lP = lPr = lwp.toInt();
        }
        else if((lWidth.isEven && lSL.isOdd) || (lWidth.isOdd && lSL.isEven)){
            final int lwp = ((lWidth - lSL)/2).round();
            lP = lwp;
            lPr = lwp-1;
        }   
        final int rSL = _length(rStr);
        if((rWidth.isEven && rSL.isEven) || (rWidth.isOdd && rSL.isOdd)){
            final double rwp = (rWidth - rSL)/2;
            rP = rPr = rwp.toInt();
        }
        else if((rWidth.isEven && rSL.isOdd) || (rWidth.isOdd && rSL.isEven)){
            final int rwp = ((rWidth - rSL)/2).round();
            rP = rwp;
            rPr = rwp-1;
        }   


*/ 


        // if(maxLenght < curConWidth-lbcWidth-rbcWidth){ 
        //     lWidth = lbcWidth;
        //     rWidth = rbcWidth;
        // } 
        // else if(doFitBC) {
        //     if(curConWidth > maxLenght){
        //         final int value = curConWidth - maxLenght;
        //         if(value>=minBCWidth*2){
        //             final int newWidth = (value%2 == 0 ? value/2 : (value-1)/2).toInt();
        //             lWidth = newWidth;
        //             rWidth = newWidth;
        //         }
        //         else{
        //             Console.setConsoleSize(width: maxLenght+lbcWidth+rbcWidth);
        //             lWidth = lbcWidth;
        //             rWidth = rbcWidth;
                    
        //         }
        //     }
        //     else{
        //         Console.setConsoleSize(width: maxLenght+lbcWidth+rbcWidth);
        //         lWidth = lbcWidth;
        //         rWidth = rbcWidth;
        //         curConWidth = Console.width;
        //     }
        // }
        // else{
        //     Console.setConsoleSize(width: maxLenght+lbcWidth+rbcWidth);
        //     lWidth = lbcWidth;
        //     rWidth = rbcWidth;
        //     curConWidth = Console.width;
        // }


        /* 
        
        
        print("maxLen: " + maxLen.toString);
        print("Console.width: " + Console.width.toString());
        print("lWidth: " + _lWidth.toString());
        print("rWidth: " + _rWidth.toString());
        print("mWidth: " + _mWidth.toString());
        print("mmWidth: " + _mmWidth.toString());
        print("mbmWidthL: " + _mbmWidthL.toString());
        print("mbmWidthR: " + _mbmWidthR.toString());
        
        
         */