/*
Order — модель заявки на биржу или рынок.

Назначение:
- Представляет intent: купить/продать количество актива.
- Служит единицей для MatchingEngine/OrderBook.

Обязательные поля:
- String id
- String companyId
- String productSymbol
- String side            // "buy" | "sell"
- String type            // "market" | "limit"
- double qty
- double? limitPrice
- String status          // "New"|"Queued"|"PartiallyFilled"|"Filled"|"Canceled"
- int createdTick
- int updatedTick

Инварианты:
- qty > 0
- Если type == "limit" -> limitPrice != null && limitPrice >= 0.01
- При type == "market" -> limitPrice == null
- status должен переходить по жизненному циклу последовательно

Публичные методы (словесно):
- isMarket() -> bool
- remainingQty() -> double   // если частично исполнен

Сериализация:
- toMap: все поля + "_schema"/"_version"
- fromMap: валидировать инварианты, при ошибке — бросать доменное исключение

Event-публикации (через сервис/engine):
- OrderQueued { orderId, companyId, productSymbol, side, qty, tick }
- OrderPartiallyFilled { orderId, filledQty, remainingQty, price, tick }
- OrderFilled { orderId, filledQty, price, tick }
- OrderCanceled { orderId, reason, tick }

Ошибки/Result-коды:
- "InvalidOrderQty"
- "InvalidLimitPrice"
- "OrderNotFound"
- "OrderAlreadyFilled"

Тесты:
- создание limit без limitPrice -> fail
- market order with no liquidity -> behavior: reject (Result.fail("NoLiquidity")) or place? В проекте решаем: reject with "NoLiquidity"
*/
