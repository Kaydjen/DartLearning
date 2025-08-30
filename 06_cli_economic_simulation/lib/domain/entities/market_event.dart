/*
MarketEvent — событие внешнего мира, влияющее на цены и рынок.

Назначение:
- Описывать новости/слухи/шоки, которые умножают волатильность или напрямую влияют на цену.
- Генерируются EventGenerator / Admin CLI / внешние скрипты.

Обязательные поля:
- String id
- String kind           // "Rumor"|"News"|"Shock"
- String? productSymbol // опционально; null означает общий рынок
- double impact         // значение в диапазоне [-1.0 .. +1.0] (направление и сила)
- int durationTicks     // сколько тиков событие активно (>=1)
- int createdTick

Инварианты:
- impact в [-1,1]
- durationTicks >= 1

Публичные методы (словесно):
- isActive(currentTick) -> bool
- applyToPrice(basePrice, productSensitivity) -> double // описать алгоритм в PricingStrategy (см. pricing)

Сериализация:
- toMap/fromMap как обычно

События:
- MarketEventPublished { id, kind, productSymbol, impact, durationTicks, tick }
- MarketEventExpired { id, tick }

Тесты:
- влияние события на price соответствует описанному алгоритму в PricingStrategy
*/
