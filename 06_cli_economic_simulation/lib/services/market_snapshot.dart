/*
MarketSnapshot — структура, передающая срез рынка (цены, объёмы, события) ботам/стратегиям.

Содержит:
- tickIndex
- Map<symbol, {bestBid,bestAsk,lastPrice,liquidityEstimate}>
- activeEvents: List<MarketEvent>
- lastTrades: Map<symbol,List<Trade>> (опционально)

Используется в:
- BotContext
- PricingStrategy

Замечание: должна быть immutable при передаче боту/стратегии, чтобы исключить side-effects
*/
