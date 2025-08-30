/*
OrderBook / LimitOrderBook — хранит все лимитные заявки для одного symbol.

Назначение:
- bids: Map<price, Queue<Order>> (prices sorted desc)
- asks: Map<price, Queue<Order>> (prices sorted asc)

Правила:
- price-time priority: лучшие цены исполняются первыми; при равной цене — старее первым
- частичное исполнение разрешено
- везде хранить ссылки на Order.id, а при исполнении обращаться к глобальному репозиторию orders

Публичные методы (словесно):
- addLimitOrder(order) -> Result (вставляет в bucket)
- removeOrder(orderId) -> Result
- getBestBid() -> (price, volume)
- getBestAsk() -> (price, volume)
- snapshot() -> structure for market data (top N levels)

Edge cases:
- если порядок цен float — сравнивать с допустимой точностью (toFixed(8) или хранить в integer smallest units)
- market orders: по решению проекта — reject при отсутствии встречной ликвидности (Result.fail("NoLiquidity"))

Performance:
- use tree/map structure for price levels; each level has queue for FIFO
- for small prototype Map+List is ok, но документируй hot spots

Testing:
- add 3 bids/asks at same price, ensure FIFO
- partial fill logic correctness
*/
