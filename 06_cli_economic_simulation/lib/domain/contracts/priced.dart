/*
Contract: Priced
Роль: источник адресуемых текущих цен и истории (last price).

Методы (описание):
- priceOf(symbol) -> double
  Возвращает вычисленную текущую цену актива symbol. Должна быть >= 0.01.

- lastPrice(symbol) -> double
  Возвращает цену предыдущего тика (или basePrice до первого тика).

Замечание:
- Источником реализации является MarketService + PricingStrategy.
- При изменении цены реализация обязана публиковать событие PriceChanged в EventBus.
*/
