/*
Extension methods — sugar для вывода и агрегаций.

Примеры:
- double.asMoney() -> String  // форматирование с 2 знаками и разделителями
- double.asPercent() -> String
- String.padCenter(width)
- List<Order>.totalQty()
- EntityRepo.firstByName(name)

Правило:
- расширения не изменяют домен; они лишь облегчают вывод/форматирование
*/
