import 'dart:math';
import 'color.dart';
import 'console.dart';
import 'prompt_handler.dart';

/// i know, i know. It's better to write there contractor and not static methods... but, who gives a shit
///
class Cli {
    static int _lWidth = 0; // left column width
    static int _rWidth = 0; // right column width
    static int _mmWidth = 0; // middle-middle column width
    static int _mbmWidthR = 0; // middle between middle column width Left
    static int _mbmWidthL = 0; // middle between middle column width Right
    static int _mWidth = 0; // whole middle column width 
    static String _colorOutline = Color.darkGray;
    static const int _minBCWidth = 3;
    /// [doSetTMC] - do set top-middle column 
    static void setColumn(
        Map<int, CliOptions> map, 
        {
            String lbcStr = "◊",
            String rbcStr = "◊",
            String mbcStr = "¯\\(0-0)/¯",
            bool doSetTMC = true, 
            int lbcWidth = 7, 
            int rbcWidth = 7,
            bool doFitBC = true,
            int topBorder = 1,
            int bottomBorder = 1,
            int textIndDesc = 2,
            int textIndOpt = 4,
            String colorOutline = Color.darkGray,
            String colorTextDesc = Color.grayDark,
            String colorTextOpt = Color.darkRed,
            String colorTextNum = Color.darkRed,
            String colorLBC = Color.grayDark,
            String colorRBC = Color.grayDark,
            String colorMBC = Color.grayDark,
        }){
        _colorOutline = colorOutline;
        lbcWidth = max(3, lbcWidth);
        rbcWidth = max(3, rbcWidth);
        Console.clear();
        Console.placeCursor(1);
         
        int maxLen = 0;
        for (var el in map.values) {
          maxLen = max(maxLen, max(el.descLenght+textIndDesc+4, el.optLenght+textIndOpt+4));
        }

        final int value = Console.width - maxLen;
        if (maxLen < Console.width - lbcWidth - rbcWidth) {
            _lWidth = lbcWidth;
            _rWidth = rbcWidth;
        } else if (doFitBC && value >= _minBCWidth * 2) {
            _lWidth = _rWidth = (value ~/ 2);
        } else {
            Console.setConsoleSize(width: maxLen + lbcWidth + rbcWidth);
            _lWidth = lbcWidth;
            _rWidth = rbcWidth;
        }
        _countMWidth();
        _mmWidth = _length(mbcStr)+2;
        if(_mmWidth>_mWidth){
            Console.setConsoleSize(width: Console.width+(_mmWidth-_mWidth)+2);
            _countMWidth();
        }
        
        final int mbmW = _mWidth - _mmWidth-2;
        if(mbmW.isOdd) {
            _mbmWidthL = (mbmW/2).round();
            _mbmWidthR = _mbmWidthL-1;
        }

        // TOP
        _printLn(crl: "┌", cnl: "┐", hlm: " ", cnml: "┌", cnmr: "┐", hrm: " ", cnr: "┌", crr: "┐");
        _print(lStr: colorLBC+lbcStr, mStr:  "│"+colorMBC+_pad(_mmWidth, mbcStr)+_colorOutline+"│",rStr: colorRBC+rbcStr, mPl: _mbmWidthL);
        _printLn(crl: "└", cnl: "┘", hlm: " ", cnml: "└", cnmr: "┘", hrm: " ", cnr: "└", crr: "┘");

        // MIDDLE-TOP
        _printLn(crl: "┌", cnl: "┬",  cnml: "─", cnmr: "─", cnr: "┬", crr: "┐");
        //_printLn(crl: "┌", cnl: "┐",  cnml: "─", cnmr: "─", cnr: "┌", crr: "┐");

        // MIDDLE
        if((Console.height-map.length-5-topBorder-bottomBorder) < 0){
            Console.setConsoleSize(height: map.length+5+topBorder+bottomBorder);
        }
        for (var el in map.entries) {
            _print(mPl: textIndDesc, lStr: colorTextNum + el.key.toString(), mStr: colorTextDesc + el.value.des);
            _print(mPl: textIndOpt, mStr: colorTextOpt + el.value.opt);
        }

        // MIDDLE-DOWN
        //_printLn(crl: "└", cnl: "┘",  cnml: "─", cnmr: "─", cnr: "└", crr: "┘");
        _printLn(crl: "└", cnl: "┴",  cnml: "─", cnmr: "─", cnr: "┴", crr: "┘");
    }
    static void _countMWidth(){
        _mWidth = Console.width-_lWidth-_rWidth-4;
        if (_mWidth.isOdd) {
          _mWidth++;
          Console.setConsoleSize(width: Console.width + 1);
        }
    }
    static void _print({String lStr = "", String mStr = "", String rStr = "", int mPl = 2, String vl = "│"}) {
        final int mPr = _mWidth - _length(mStr) - mPl;
        vl = _colorOutline+vl;
        print( 
            vl + _pad(_lWidth, lStr) + vl
            + " "*mPl + mStr + " "*mPr 
            + vl + _pad(_rWidth, rStr) + vl
        );
    }
    static String _pad(int width, String str) {
        int len = _length(str);
        int p = ((width - len) / 2).round();
        return " " * p + str + " " * (width - len - p);
    }
    /// Prints a formatted line with customizable symbols and connectors.
    /// 
    /// !WARNING!
    /// Don't forget, this is only for printing top and down lines, also for printing three boxes. 
    ///
    /// crl hl cnl hlm cnml hmm cnmr hrm cnr hr crr
    /// 
    /// └ ── ┴ ──── ┴ ───── ┴ ──── ┴ ── ┘
    // └ ────────── ┴ ───────────────── ┴ ────────── ┴ ───────────────── ┴ ────────── ┘
    /// 
    /// Parameters:
    /// - [crl]: corner left symbol (default: "└")
    /// - [hl]: horizontal line left (default: "─")
    /// - [cnl]: connector left (default: "┴")
    /// 
    /// 
    /// - [hlm]: horizontal line middle-left (default: "─")
    /// - [cnml]: connector middle-left (default: "┴")
    /// 
    /// - [hmm]: horizontal line middle-middle (default: "─")
    /// 
    /// - [cnmr]: connector middle-right (default: "┴")
    /// - [hrm]: horizontal line right-middle  (default: "─")
    /// 
    /// 
    /// - [cnr]: connector right (default: "┴")
    /// - [hr]: horizontal line right  (default: "─")
    /// - [crr]: corner right symbol (default: "┘")
    static void _printLn({
        String crl = "└",
        String hl = "─", 
        String cnl = "┴",
        String hlm = "─", 
        String cnml = "┴",
        String hmm = "─",
        String cnmr = "┴",
        String hrm = "─",
        String cnr = "┴",
        String hr = "─",
        String crr = "┘",
    }) {
        print(_colorOutline
        + crl + hl*_lWidth + cnl
        + hlm*_mbmWidthL
        + cnml + hmm*_mmWidth + cnmr
        + hrm*_mbmWidthR
        + cnr + hr*_rWidth + crr);
    }
    static int _length(String input) => input.replaceAll(RegExp(r'\x1B\[[0-9;]*[a-zA-Z]'), '').length;
}

class CliOptions{
    final String des;
    final String opt;
    CliOptions({required this.des, required this.opt});

    int get descLenght => Prompt.visibleLength(des);
    int get optLenght => Prompt.visibleLength(opt);
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