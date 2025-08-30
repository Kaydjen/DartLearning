/*
Portfolio — структура для хранения позиций компании.

Назначение:
- Поддерживать словарь symbol -> qty (double)
- Предоставлять операции чтения/агрегации (totalValue на snapshot)

Обязательные поля:
- String id
- Map<String,double> positions   // ключ: productSymbol, значение: qty

Инварианты:
- Для всех позиций qty >= 0
- Изменять позиции можно только через сервисы (MarketService/MatchingEngine)

Публичные методы (словесно):
- getQty(symbol) -> double
- addPosition(symbol, deltaQty) -> Result  // deltaQty может быть положительным или отрицательным; осуществляет проверку инвариантов
- totalValue(MarketSnapshot) -> double

Сериализация:
- toMap: { "id", "positions": {symbol: qty,...}, "_schema","_version" }

Тесты:
- addPosition с отрицательным результатом qty -> Result.fail("InsufficientAsset")
- totalValue корректно суммирует позиции по текущим ценам
*/
