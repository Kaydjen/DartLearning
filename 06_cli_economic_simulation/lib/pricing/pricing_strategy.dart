/*
PricingStrategy — контракт для вычисления цены актива.

Назначение:
- Обеспечивать формулу и логику, по которой MarketService получает ценовую оценку для продукта.

API (словесно):
- currentPrice(Product product, MarketContext ctx) -> double
  - product: DTO продукта (basePrice, volatility)
  - ctx: MarketContext (lastPrices, activeEvents, liquidity)
  - возвращаемое значение >= 0.01

Описание стратегий (в отдельных файлах):
- conservative: сглаживание на последних N тиках (N=5 дефолт), малый коэффициент волатильности
- volatile: реагирует на события по сильной формуле, высокая амплитуда
- trend: учитывает slope последних N цен, добавляет трендовую компоненту

Требования к реализации:
- стратегии должны быть pure-функциями (без побочных эффектов).
- эффекты событий (impact/duration) должны аккумулироваться по активным событиям в ctx.

Тесты:
- deterministic given MarketContext и Product -> same price
*/
