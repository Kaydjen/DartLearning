/*
CLI — thin adapter: parse input -> validate -> call services -> print short result.

Команды (сигнатуры):
- help
- exit
- price <SYMBOL>
- buy <SYMBOL> <QTY> [<MAXPRICE>]
- sell <SYMBOL> <QTY> [<MINPRICE>]
- portfolio
- news
- bots
- pause
- resume
- save <slot>
- load <slot>

Принципы:
- CLI не меняет доменные объекты напрямую
- Все вызываемые методы async -> await; CLI не блокирует тикер
- Errors printed short: "Error: <reason>"; details in Logger

Validation rules (пример):
- QTY > 0
- SYMBOL exists
- If limit order: price >= 0.01

Testing:
- script runner: execute list of commands from file (non-interactive mode)
*/
