/*
OrderMatcher — алгоритм сопоставления ордеров одного OrderBook.

Назначение:
- при получении новой заявки (market/limit) выполнять матчи с встречной стороной
- публиковать события OrderPartiallyFilled/OrderFilled
- применять feeRate (по умолчанию 0.001)

Алгоритм (описать пошагово):
1) если incoming.type == market:
   a) взять лучшую встречную сторону, исполнить по встречной цене, уменьшить qty обеих сторон...
   b) если встречной стороны нет -> Result.fail("NoLiquidity")
2) если limit:
   a) если есть встречная заявка, удовлетворяющая ценой -> match по встречной цене
   b) иначе добавить в book
3) при каждом исполнении:
   - вычислить fee = executedPrice * executedQty * feeRate
   - adjust balances via Tradable.settleTrade
   - publish events

Concurrency note:
- matching выполняется синхронно в тик-цикле
- не позволять параллельные match'и на одном orderbook

Testing:
- market order consumes multiple levels if qty big
- partial fills produce correct remainingQty and events
*/
