/*
MatchingEngine — оркестратор матчей: принимает ордера, выбирает orderbook, вызывает OrderMatcher.

Назначение:
- принимать входящие OrderSpec/Order
- проверять canBuy/canSell (Tradable contract) перед размещением/матчем
- координировать публикацию результатов и обновление репозиториев

Публичное API (словесно):
- submitOrder(Order) -> Result
- cancelOrder(orderId) -> Result
- processTick(tick) -> void  // может инициировать репроцессинг очереди

Замечания:
- submitOrder должна: validate -> add to orderbook or match directly -> settle via Tradable.settleTrade
- все state mutations через engine должны логироваться (audit)
*/
