/*
SaveLoadService — асинхронная сериализация/десериализация состояния.

API:
- Future<Result> save(String slot)  // writes to saves/slot.json (atomic write tmp+rename)
- Future<Result> load(String slot)  // pause ticker, load, validate, resume

Формат JSON (ключи):
{
  "_schema": "rivals_rumors_exchange",
  "_version": 1,
  "tick": 123,
  "products":[{...}],
  "companies":[{...}],
  "portfolios":[{...}],
  "orders":[{...}],
  "events":[{...}]
}

Правила:
- save должен вызывать ticker.pause() перед snapshott'ом
- load валидирует _version, инварианты (баланс >=0 etc); при ошибке возвращает Result.fail("Corrupted save")
- write must be atomic: write to temp file then rename

Тесты:
- save -> quit -> load -> state equivalence by key fields
*/
