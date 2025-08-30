/*
EventBus — реактивная шина событий (Streams).

Назначение:
- publish(event), subscribe<T>(), subscribeOnce<T>(), dispose()

Политика:
- broadcast streams
- отправитель НЕ знает подписчиков
- слушатель обязан читать; если подписчик отстаёт — использовать фильтрацию/сэмплинг

Типы событий (events.dart):
- PriceChanged {productSymbol, oldPrice, newPrice, tick}
- TickHappened {tick}
- OrderQueued / OrderFilled / OrderPartiallyFilled / OrderCanceled
- MarketEventPublished / MarketEventExpired
- CompanyBalanceChanged / CompanyBankrupt
- BotDecision

Рекомендации по обработке:
- фильтровать события по symbol при подписке для уменьшения нагрузки
- использовать buffer/sliding window для аналитики, а не держать «все» события
*/