import 'color.dart';
import 'console.dart';
import 'prompt_handler.dart';

class Cli {
    static int lWidth = 0; 
    static int rWidth = 0;
    static int mmWidth = 0;
    static int mbmWidth = 0; 
    static int mWidth = 0; 
    static void setColumn(/* Map<int, CliOptions> map */){
        Console.clear();
        Console.placeCursor(1);
        // перебрать весь масив и вычислить среднее значение int, если оно равно 1 или не парное - то левая и правая шырины должны быть не парными,
        // а если среднее будет выше 1 и парное - то и ширины должны быть парными 
        lWidth = 9-2; // left column width
        rWidth = 9-2; // right column width
        mmWidth = 15-2; // middle-middle column width
        mbmWidth = Console.width-lWidth-rWidth-mmWidth-6; // middle between middle column width
        mWidth = Console.width-lWidth-rWidth-4; // whole middle column width                             
        
        // TOP
        _printLn(crl: "┌", cnl: "┐", hlm: " ", cnml: "┌", cnmr: "┐", hrm: " ", cnr: "┌", crr: "┐");
        _print("◊", _middleText("◊◊"), "◊", mPl: (mbmWidth/2).toInt());
        _printLn(crl: "└", cnl: "┘", hlm: " ", cnml: "└", cnmr: "┘", hrm: " ", cnr: "└", crr: "┘");

        // MIDDLE-TOP
        _printLn(crl: "┌", cnl: "┬",  cnml: "─", cnmr: "─", cnr: "┬", crr: "┐");
        //_printLn(crl: "┌", cnl: "┐",  cnml: "─", cnmr: "─", cnr: "┌", crr: "┐");

        // MIDDLE
        _print("◊", "", "◊", mPl: (mbmWidth/2).toInt());

        // MIDDLE-DOWN
        //_printLn(crl: "└", cnl: "┘",  cnml: "─", cnmr: "─", cnr: "└", crr: "┘");
        _printLn(crl: "└", cnl: "┴",  cnml: "─", cnmr: "─", cnr: "┴", crr: "┘");
    }
    static void _print(String lStr, String mStr, String rStr, {int mPl = 2, String vl = "│"}){  // mPl - middle padding from left, vl vertical line Symbol
        int lP = ((lWidth - _length(lStr)) / 2).toInt(); // left text padding
        int rP = ((rWidth - _length(rStr)) / 2).toInt(); // right text padding
        int mPr =  mWidth - _length(mStr) - mPl; // mPr - middle padding from right 
        print(
            vl + " "*lP + lStr + " "*lP + vl
            + " "*mPl + mStr + " "*mPr
            + vl + " "*rP + (rStr.length == 0 ? " " : rStr) + " "*rP + vl);
    }
    /// Prints a formatted line with customizable symbols and connectors.
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
        int mWidth = (mbmWidth / 2).toInt(); // middle width
        print(Color.darkGray()
        + crl + hl*lWidth + cnl
        + hlm*mWidth
        + cnml + hmm*mmWidth + cnmr
        + hrm*mWidth
        + cnr + hr*rWidth + crr);
    }
    // /// Prints a formatted line with customizable symbols and connectors.
    // ///
    // /// Parameters:
    // /// - [l]: left symbol (default: "└")
    // /// - [c]: left connector (default: "┴")
    // /// - [h]: middle-horizontal symbol (default: "─")
    // /// - [r]: right symbol (default: "┘")
    // static void _printLn({
    //     String l = "└",
    //     String c = "┴",
    //     String h = "─", 
    //     String r = "┘",
    // }) {
    //     print(Color.darkGray()
    //     + l + h * lWidth + c 
    //     + h * (mbmWidth / 2).round()
    //     + c + h * mmWidth + c
    //     + h * (mbmWidth / 2).round()
    //     + c + h * rWidth + r);
    // }
    static String _middleText(String str){
        int p = ((mmWidth-_length(str))/2).toInt();
        return "│"+ " "*((p%2 != 0) ? p+1:p) + (str.length == 0 ? " " : str) + " "*p + "│";
    }
    static int _length(String input) => input.replaceAll(RegExp(r'\x1B\[[0-9;]*[a-zA-Z]'), '').length;
}

class Sm{
    static final String bL = '└'; // bottom left
    static final String bC = '┴';
    static final String bR = '┘';
    static final String h = '─'; // horisontal
    static final String tL = '┌'; // top left
    static final String tC = '┬';
    static final String tR = '┐';
}



class CliOptions{
    final String description;
    final String option;
    CliOptions(this.description, this.option);

    int get descLenght => Prompt.visibleLength(description);
    int get optLenght => Prompt.visibleLength(option);
}