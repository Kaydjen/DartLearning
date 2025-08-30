/*
Краткий словарь терминов (для разработчика):

Exchange — модель централизованной биржи.
Order Book — bids/asks per symbol.
Bid — заявление купить.
Ask — заявление продать.
Market Order — исполнить немедленно по лучшей цене.
Limit Order — исполнить при достижении цены.
Spread — ask - bid.
Liquidity — объём доступных ордеров на уровнях.
Slippage — разница ожидаемой и фактической цены.
Maker/Taker — добавляет/забирает ликвидность.

Design notes:
- Matching synchronous in tick
- market orders rejected if no liquidity
- save only when ticker paused
- events via EventBus
*/


Глоссарий

Семантика — смысл/назначение; когда говорим «семантика метода», имеем в виду, какую работу он должен выполнить (что означает), а не как именно.

OrderBook — список всех открытых лимитных заявок по цене.

Maker/Taker — maker добавляет ордер в книгу, taker исполняет против существующей заявки.

K-line — сводная свеча: Open/High/Low/Close/Volume за период.

Backpressure — механизм защиты от переполнения очереди, когда подписчик не успевает читать события.

Isolate (Dart) — отдельный воркер/процесс без разделяемой памяти (используется для тяжёлых вычислений).






Стандартные коды ошибок

"InvalidEntity"
"InsufficientFunds"
"InsufficientAsset"
"InvalidQuantity"
"OrderConflict"
"RepoConflict"
"NoLiquidity"
"InvalidLimitPrice"
"CorruptedSave"
"CompanyBankrupt"
"PermissionDenied"
"NotFound"
