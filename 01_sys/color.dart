
mixin Color{
    static String _previousColor = "";
    /// [keepColor] - keep color that was setted
    static String set(ColorTypes type, {str = "", bool keepColor = true}) {
        final color = colorTypeMap[type]!; // todo: make color request from map safer (or it's unnecessary)
        if (keepColor) _previousColor = color;
        return '$color$str$_previousColor';
    }

    // main colors
    static const String red = "\u001b[38;5;196m";
    static const String green = "\u001b[38;5;2m";
    static const String blue = "\u001b[38;5;27m";
    static const String white = "\u001b[38;5;15m";

    // dark colors
    static const String darkRed = "\u001b[38;5;1m";
    static const String darkBlue = "\u001b[38;5;4m";

    // bright colors
    //static String brightRed() => "\u001b[38;5;14m";
    static const String brightGreen = "\u001b[38;5;10m";
    static const String brightMagenta = "\u001b[38;5;13m";
    static const String brightCyan = "\u001b[38;5;14m";
    static const String brightWhite = "\u001b[38;5;15m";

    // additional gray colors
    static const String darkGray = "\u001b[38;5;236m";
    static const String grayDark = "\u001b[38;5;240m";
    static const String gray = "\u001b[38;5;245m";
    static const String grayWhite = "\u001b[38;5;250m";

    // background colors
    static const String bgdarkGray = "\u001b[48;5;234m";
    static const String bgBlack = "\u001b[48;5;0m";
    static const String bgRed = "\u001b[48;5;1m";
    static const String bgGreen = "\u001b[48;5;2m";
    static const String bgYellow = "\u001b[48;5;3m";
    static const String bgBlue = "\u001b[48;5;4m";
    static const String bgMagenta = "\u001b[48;5;5m";
    static const String bgCyan = "\u001b[48;5;6m";
    static const String bgWhite = "\u001b[48;5;7m";

    // reset color
    static const String reset = "\u001b[38;5;255m";
}
enum ColorTypes{
    red,
    brightGreen,
    brightCyan,
    grayWhite,
    def,
}
Map<ColorTypes, String> colorTypeMap = {
    ColorTypes.red: Color.red,
    ColorTypes.brightGreen: Color.brightGreen,
    ColorTypes.brightCyan: Color.brightCyan,
    ColorTypes.def: Color.reset,
    ColorTypes.grayWhite: Color.grayWhite,
};