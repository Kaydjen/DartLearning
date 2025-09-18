
mixin Color{
    static String _previousColor = "";
    /// [keepColor] - keep color that was setted
    static String set(ColorTypes type, {str = "", bool keepColor = true}) {
        final color = colorTypeMap[type]!; // todo: make color request from map safer (or it's unnecessary)
        if (keepColor) _previousColor = color;
        return '$color$str$_previousColor';
    }

    // main colors
    static String red() => "\u001b[38;5;196m";
    static String green() => "\u001b[38;5;2m";
    static String blue() => "\u001b[38;5;27m";
    static String white() => "\u001b[38;5;15m";

    // dark colors
    static String darkRed() => "\u001b[38;5;1m";
    static String darkBlue() => "\u001b[38;5;4m";

    // bright colors
    //static String brightRed() => "\u001b[38;5;14m";
    static String brightGreen() => "\u001b[38;5;10m";
    static String brightMagenta() => "\u001b[38;5;13m";
    static String brightCyan() => "\u001b[38;5;14m";
    static String brightWhite() => "\u001b[38;5;15m";

    // additional gray colors
    static String grayDark() => "\u001b[38;5;240m";
    static String gray() => "\u001b[38;5;245m";
    static String grayWhite() => "\u001b[38;5;250m";

    // background colors
    static String bgBlack() => "\u001b[48;5;0m";
    static String bgRed() => "\u001b[48;5;1m";
    static String bgGreen() => "\u001b[48;5;2m";
    static String bgYellow() => "\u001b[48;5;3m";
    static String bgBlue() => "\u001b[48;5;4m";
    static String bgMagenta() => "\u001b[48;5;5m";
    static String bgCyan() => "\u001b[48;5;6m";
    static String bgWhite() => "\u001b[48;5;7m";

    // reset color
    static String reset() => "\u001b[38;5;255m";
}
enum ColorTypes{
    red,
    brightGreen,
    brightCyan,
    grayWhite,
    def,
}
Map<ColorTypes, String> colorTypeMap = {
    ColorTypes.red: Color.red(),
    ColorTypes.brightGreen: Color.brightGreen(),
    ColorTypes.brightCyan: Color.brightCyan(),
    ColorTypes.def: Color.reset(),
    ColorTypes.grayWhite: Color.grayWhite(),
};