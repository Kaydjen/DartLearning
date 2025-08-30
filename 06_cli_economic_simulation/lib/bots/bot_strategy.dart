/*
BotStrategy — контракт: decide(BotContext) -> List<OrderSpec>

BotContext содержит:
- marketSnapshot
- portfolio snapshot
- balance
- lastNEvents
- tickIndex

Примеры стратегий:
- aggressive: high volume, weak price constraints, attempts momentum trades
- conservative: strict LIMITs, small position sizing
- trend_follower: if 3 consecutive ticks up -> buy; 3 down -> sell

Рекомендации:
- use RNG with seed for deterministic test runs
- strategies should not mutate global state; return OrderSpec DTOs
*/
