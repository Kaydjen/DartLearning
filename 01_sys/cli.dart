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
    static const CliLineSymbols _sTopUp = CliLineSymbols(crl: "┌", cnl: "┐", hlm: " ", cnml: "┌", cnmr: "┐", hrm: " ", cnr: "┌", crr: "┐");
    static const CliLineSymbols _sTopDown = CliLineSymbols(crl: "└", cnl: "┘", hlm: " ", cnml: "└", cnmr: "┘", hrm: " ", cnr: "└", crr: "┘");
    static const CliLineSymbols _sUp = CliLineSymbols(crl: "┌", cnl: "┬",  cnml: "─", cnmr: "─", cnr: "┬", crr: "┐");
    static const CliLineSymbols _sDown = CliLineSymbols(crl: "└", cnl: "┴",  cnml: "─", cnmr: "─", cnr: "┴", crr: "┘");
/*     static (Line, Line, Line, Line) setLines({Line? topUp, Line? topDown, Line? up, Line? down}){ // It's a piece of shit and I know it, just leave it
        topUp ??= Line([ // (crl: "┌", cnl: "┐", hlm: " ", cnml: "┌", cnmr: "┐", hrm: " ", cnr: "┌", crr: "┐");
            LineL( sb: "┌", len: _lWidth),
            LineL( sb: "┐", len: 0),
            LineL( sb: " ", len: _mbmWidthL),
            LineL( sb: "┌", len: _mmWidth),
            LineL( sb: "┐", len: 0),
            LineL( sb: " ", len: 0),
            LineL( sb: "", len: _mbmWidthR),
            LineL( sb: "┌", len: ),
            LineL( sb: "", len: ),
            LineL( sb: "", len: ),
        ]);
    } */
/*     static const Map<int, CliOptions> _map = {
        0: CliOptions(),
    } */
    /// [doSetTMC] - do set top-middle column 
    static void setColumn(
        Map<int, CliOptions> map, 
        {
            String lbcStr = "◊", // Left border column string
            String rbcStr = "◊", // Right border column string
            String mbcStr = "¯\\(0-0)/¯", // Middle border column string
            bool doSetTMC = true, // Whether to set top-middle column
            int lbcWidth = 7, // Left border column width
            int rbcWidth = 7, // Right border column width
            bool doFitBC = true, // Fit border columns if possible
            int topBorder = 1, // Top border height
            int bottomBorder = 1, // Bottom border height
            int textIndDesc = 2, // Indent for description text
            int textIndOpt = 4, // Indent for option text
            String colorOutline = Color.darkGray, // Outline color
            String colorTextDesc = Color.grayDark, // Description text color
            String colorTextOpt = Color.darkRed, // Option text color
            String colorTextNum = Color.darkRed, // Number text color
            String colorLBC = Color.grayDark, // Left border column color
            String colorRBC = Color.grayDark, // Right border column color
            String colorMBC = Color.grayDark, // Middle border column color
            bool doWriteIndex = true, // Whether to write the index number for each option
            CliLineSymbols sTopUp = _sTopUp,
            CliLineSymbols sTopDown = _sTopDown,
            CliLineSymbols sUp = _sUp,
            CliLineSymbols sDown = _sDown,
        }){
        _colorOutline = colorOutline;
        lbcWidth = max(3, lbcWidth);
        rbcWidth = max(3, rbcWidth);
        Console.clear();
        Console.placeCursor(1);
         
        int maxLen = 0;
        for (var el in map.values) {
          maxLen = max(maxLen, max(el.descLength+textIndDesc+4, el.optLength+textIndOpt+4));
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
        _printLn(s: sTopUp);
        _print(lStr: colorLBC+lbcStr, mStr:  "│"+colorMBC+_pad(_mmWidth, mbcStr)+_colorOutline+"│",rStr: colorRBC+rbcStr, mPl: _mbmWidthL);
        _printLn(s: sTopDown);

        // MIDDLE-TOP
        _printLn(s: sUp);

        // MIDDLE
        if((Console.height-map.length-5-topBorder-bottomBorder) < 0){
            Console.setConsoleSize(height: map.length+5+topBorder+bottomBorder);
        }
        for (var el in map.entries) {
            _print(mPl: textIndDesc, lStr: colorTextNum + (doWriteIndex ? el.key.toString() : ""), mStr: colorTextDesc + el.value.des);
            _print(mPl: textIndOpt, mStr: colorTextOpt + el.value.opt);
        }

        // DOWN
        _printLn(s: sDown);
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
        CliLineSymbols s = const CliLineSymbols(),
    }) {
        print(_colorOutline
        + s.crl + s.hl*_lWidth + s.cnl
        + s.hlm*_mbmWidthL
        + s.cnml + s.hmm*_mmWidth + s.cnmr
        + s.hrm*_mbmWidthR
        + s.cnr + s.hr*_rWidth + s.crr);
    }
    static int _length(String input) => input.replaceAll(RegExp(r'\x1B\[[0-9;]*[a-zA-Z]'), '').length;
}
/* enum Place{
    start, // from start of line to the left
    midLeft, // from mid of the line to the left
    midRight, // from mid of the line to the right
    end // from the end of the line to the left
} */
enum Side{
    left,
    right
}
class LineL{
    String sb; // symbol which will be placed in collumn in the specified place
    String sbFill; // symbol to fill the emply space on line
    int len; // lenght of symbols from sb to the side pointed in indent
    Side dir; // indent to next symbol OR it is the space, that will be filled with sbFill 
    LineL({this.sb = "", this.sbFill = "─", this.len = 0, this.dir = Side.right});
}
class Line{ // I'm sorry 
    String s = "";
    List<LineL>? list;
    Line([this.list]);

    int requiredStrLen = 20;

    String tryToSetUpStr(){
        if(list == null) return "";
        String str = "";
        for (var el in list!) {
            final String sbFill = el.sbFill * el.len;
            str += el.dir == Side.left ? sbFill + el.sb : el.sb + sbFill;
        }
        return str;
    }
    void println(){
        if(s.length == 0) s = tryToSetUpStr();
        print(s);
    }
}

class CliLineSymbols {
    final String crl;
    final String hl;
    final String cnl;
    final String hlm;
    final String cnml;
    final String hmm;
    final String cnmr;
    final String hrm;
    final String cnr;
    final String hr;
    final String crr;

    const CliLineSymbols({
        this.crl = "└",
        this.hl = "─",
        this.cnl = "┴",
        this.hlm = "─",
        this.cnml = "┴",
        this.hmm = "─",
        this.cnmr = "┴",
        this.hrm = "─",
        this.cnr = "┴",
        this.hr = "─",
        this.crr = "┘",
    });
}

class CliOptions {
    final String des;
    final String opt;
    final String shortOpt;
    final void Function()? func;
    final Map<String, void Function(String value)>? flags;

    CliOptions({
        required this.des,
        this.opt = "",
        this.shortOpt = "",
        this.func,
        this.flags
    });

    int get descLength => Prompt.visibleLength(des);
    int get optLength => Prompt.visibleLength(opt);
    int get shortOptLength => Prompt.visibleLength(shortOpt);
    @override
    String toString() =>
            '''
        CliOptions(
          des      : "$des",
          opt      : "$opt",
          shortOpt : "$shortOpt",
          func     : $func,
          map      : $flags
        )
        ''';
}
