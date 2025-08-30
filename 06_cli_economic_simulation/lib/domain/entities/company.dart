/*
Company — сущность компании/игрока, владеющего балансом и портфелем.

Назначение:
- Хранить финансовое состояние и портфель (активы).
- Базовый "игрок" — может быть управляем пользователем или ботом (BotCompany).

Обязательные поля:
- String id
- String name
- double balance            // доступные средства (опционально: хранить в int cents)
- String portfolioId       // ссылка на Portfolio в репозитории
- String activeOrdersRepoId // ссылка на репозиторий/идентификатор очереди ордеров (опционально)

Инварианты:
- balance >= 0
- portfolio.qty(item) >= 0 для всех item
- balance и qty не должны меняться напрямую извне — только через сервисы (MarketService/MatchingEngine)

Публичные методы (словесно):
- requestBuy(symbol, qty, maxPrice?) -> Result  // инициирует покупку (создаёт Order через сервис)
- requestSell(symbol, qty, minPrice?) -> Result // инициирует продажу
- getNetWorth(marketSnapshot) -> double         // сумма balance + стоимость портфеля по текущим ценам

Сериализация:
- toMap(): { "id", "name", "balance", "portfolioId", "activeOrdersRepoId", "_schema", "_version" }
- fromMap(map): валидировать поля, не оставлять null

События, которые могут публиковаться (реализация сервисом, но укажи здесь):
- CompanyBalanceChanged { companyId, oldBalance, newBalance, tick }
- CompanyBankrupt { companyId }

Ошибки/Result-коды (рекомендация):
- "InsufficientFunds"
- "InsufficientAsset"
- "InvalidQuantity"
- "CompanyBankrupt"

Тесты/чек-лист:
- Попытка buy при недостаточном балансе — Result.fail("InsufficientFunds")
- Попытка sell сверх qty — Result.fail("InsufficientAsset")
- Баланс не уходит < 0 после settleTrade

Производительность/заметки:
- Для больших портфелей использовать Map<symbol,double> в Portfolio.
*/
