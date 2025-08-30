/*
Ticker — синхронизатор времени симуляции.

Назначение:
- выдавать тики времени в заданном интервале
- вызывать подписчиков Tickable и координировать порядок операций

Параметры (комментарии):
- defaultTickMs = 500  // длительность тика
- start(), pause(), resume(), stop(), setSpeed(factor)

Строгий порядок в одном тике (фиксировать):
1) publish TickStart (TickHappened)
2) EventGenerator генерирует новые MarketEvents
3) Pricing/MarketService пересчитывает цены (для всех symbols)
4) MatchingEngine запускает match по каждому активному orderbook
5) Запись/логи/сбор статистики
6) publish TickEnd (с итогами тика) — опционально

Замечания:
- onTick подписчики должны быть fast; тяжёлые расчёты делегировать.
- если обработка дольше tickDuration — логировать warn и отложить следующий тик (не накладывать)
- сохранить deterministic tickIndex counter

Тесты:
- pause -> tick stops
- resume -> continue incrementing tickIndex correctly
*/
