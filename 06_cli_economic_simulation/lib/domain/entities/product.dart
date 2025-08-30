/*
Product — абстрактное описание товара/актива, торгуемого на бирже/рынке.

Назначение:
- Декларация свойств товара: символ, базовая цена, волатильность, категория/тип.
- Не хранит "текущую" рыночную цену (это задача MarketService/PricingStrategy).

Обязательные поля:
- String id
- String name
- String symbol          // уникальный тикер/символ, используется в orderbook
- double basePrice       // стартовая/базовая цена
- double volatility      // фактическая "чувствительность" — коэффициент 0..∞
- String type            // например "commodity", "tech", "luxury", "token" и т.д.

Инварианты:
- basePrice >= 0.01
- volatility >= 0
- symbol — уникален в продукт-репозитории

Публичные методы (словесно):
- describe() -> String
- volatilityFactor() -> double
- sensitivityTo(eventKind) -> double

Сериализация:
- toMap: { "id","name","symbol","basePrice","volatility","type","_schema","_version" }
- fromMap: строго валидировать basePrice и volatility

Примечания реализации:
- Цена рассчитывается MarketService + PricingStrategy, а не хранится здесь.
- Для off-exchange товаров (внутренние покупки, "сервисы") можно иметь отдельную ветку logic, но Product остаётся DTO-описанием.

Тесты:
- product with invalid basePrice -> fail on fromMap
- symbol uniqueness enforced in repo layer
*/
