/*
EntityRepo<T extends Entity> — кастомный репозиторий сущностей.

Назначение:
- Хранить сущности в Map<id,T>.
- Поддерживать операции get, contains, перечисление, иммутабельные add/remove (операторы +, -).

Внутренняя структура (рекомендация):
- final Map<String,T> _byId;

Публичные методы/операторы (словесно):
- getById(String id) -> T?
- containsId(String id) -> bool
- Iterable<String> ids()
- Iterable<T> values()
- int get length
- operator [](String id) -> T?
- operator []=(String id, T value) -> void   // use internally only (load/repair)
- EntityRepo<T> operator +(T value) -> EntityRepo<T> // returns new repo with added entity; throws RepoConflict if id exists
- EntityRepo<T> operator -(String id) -> EntityRepo<T> // returns new repo without the id
- clear(), where(predicate) -> Iterable<T>

Сравнение:
- == и hashCode по набору id и сериализованным полям (deterministic order-insensitive compare)

Правила и инварианты:
- id не может быть null
- + бросает RepoConflict при дубле id (или возвращает Result.fail в зависимости от стиля)

Расширения (repo_queries_ext.dart):
- firstByName(String name) -> T?
- topN(int n, Comparable key(T)) -> List<T>

Тесты:
- repo + entity -> new repo contains entity
- repo - id -> new repo doesn't contain
- colliding add -> error
*/
import '../entities/entity.dart';

class EntityRepo<T extends Entity>{
    final Map<String,T> _byId;
    EntityRepo([Map<String, T>? initial])
        : _byId = initial ?? {};

    T? getById(String id) => _byId[id] ?? null;
    bool isKnown(String id) => !isUndefined(id) && !isNull(id) ? true : false;
    bool isUndefined(String id) => !_byId.containsKey(id) ? true : false;
    bool isNull(String id) => _byId[id] == null ? true : false;
    Iterable<String> ids() => _byId.keys;
    Iterable<T> values() => _byId.values;
    Iterable<MapEntry<String, T>> entries() => _byId.entries;
    int get length => _byId.length;
    T? operator [](String id) => _byId[id] ?? null;
    void operator []=(String id, T value) => _byId[id] = value;
}

