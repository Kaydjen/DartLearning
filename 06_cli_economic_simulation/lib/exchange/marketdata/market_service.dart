/*
MarketService — агрегатор рыночных данных и фасад доступа к ценам.

Назначение:
- предоставлять bestBid, bestAsk, lastTrades
- интегрироваться с PricingStrategy для off-book pricing (если есть)
- выдавать MarketSnapshot для аналитики и ботов

Публичное API (словесно):
- getBestBidAsk(symbol) -> {bestBidPrice, bestBidVolume, bestAskPrice, bestAskVolume}
- getLastPrice(symbol) -> double
- getLastTrades(symbol, n) -> List<Trade>
- publishTickUpdate(tick)

Также:
- поддерживать KLineService с агрегацией OHLC за периоды
- иметь hooks для подписки от CLI/GUI

Notes:
- MarketService не выполняет matching — это задача MatchingEngine, но он читает orderbook и last trades
*/
