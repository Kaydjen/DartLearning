import '../../app/appearance/color.dart';

/// Инварианты: []
///  - [errorDescription] по дефолту красится в красный цвет, внутри классах-наследниках нужно будет красить отдельно в красный, если там присутствуют другие покраски
/// 
/// Например: 
/// 
/// Bad:  
/// ```errorDescription = "текст... ${Color.set(Blue, "Symbol")}" ```
///  - вот тут после текста есть покраска, значит нужно в самом начале текста вручную покрасить его, иначе могут быть ошибки
/// 
/// Good:  
/// ```errorDescription = "${Color.set(Red, "Symbol")} текст... ${Color.set(Blue, "Symbol")}" ```
abstract class DomainError implements Exception {
  final String code;       // Код ошибки
  final String errorDescription;             // Человекочитаемое описание
  final Map<String, Object?> context; // Доп. данные для анализа
  final Object? place;              // Первопричина (например, ошибка из API)

  DomainError({
    required this.code,
    this.errorDescription = "",
    this.context = const {},
    this.place,
  });

  @override
  String toString() {
    String cont = "";
    if(!context.isEmpty) cont = _showContext(context);
    return 
        '${Color.set(ColorTypes.brightGreen, str: code)}'
        '${Color.set(ColorTypes.brightCyan, str: ":")} '
        '${Color.set(ColorTypes.red, str: errorDescription)}' 

        '$cont'

        '\n${Color.set(ColorTypes.brightGreen, str: "place")} '
        '\u001b[38;5;255m= '
        '${Color.set(ColorTypes.red, str: place)}';
  }
}

String _showContext(Map<String, Object?> context){
    String content = "\n";
    for (final el in context.entries) 
        content += 
        "\n${Color.set(ColorTypes.brightGreen, str: el.key)}"
        "\u001b[38;5;255m: "
        "${Color.set(ColorTypes.red)}"; 
    return content;
}


/* bad idea - because you must write every error firstly here, then inside error's class - it's to boring and take to much time for no reason 
enum ErrorsCodes {
    idNotFound,
    noKeys,
    noValues,
    noEntries,
    unknown,             // На всякий случай
}
 */


/// sealed - чтобы никто вне этого файла не мог "придумать" новые ошибки

/* 

    insufficientFunds,   // Недостаточно средств
    userNotFound,        // Пользователь не найден
    orderNotFound,       // Сделка/заявка не найдена
    invalidInput,        // Неверные данные
    unauthorized,        // Нет доступа
    networkError,        // Проблема с сетью
    exchangeUnavailable, // Биржа временно недоступна

 */