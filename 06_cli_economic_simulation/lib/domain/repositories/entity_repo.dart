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
import '../exeptions/repo_exceptions.dart';
import '../../../../01_sys/exceptions/result_handler.dart';

class EntityRepo<T extends Entity>{
    final Map<String,T> _byId;
    EntityRepo([Map<String, T>? initial])
        : _byId = initial ?? {};
    /// Returns Result.fail if there is no element with the given [id]
    Result<T> tryGetById(String id) => isKnown(id) // toThink: perhabs should return new el if there is no such
        ? Result.ok(_byId[id]!)
        : Result.fail(ErrorIdNotFound(id, whereHappend: this.toString()));

    bool get isEmpty => _byId.isEmpty;
    bool isKnown(String id) => !isUndefined(id) && !isNull(id) ? true : false;
    bool isUndefined(String id) => !_byId.containsKey(id) ? true : false;
    bool isNull(String id) => _byId[id] == null ? true : false;

    /// Returns Result.fail if there is no keys in data
    Result<Iterable<String>> tryGetIds() => isEmpty 
        ? Result.fail(ErrorNoKeys(whereHappend: this.runtimeType))
        : Result.ok(_byId.keys);
    /// Returns Result.fail if there is no values in data
    Result<Iterable<T>> tryGetValues() => isEmpty 
        ? Result.fail(ErrorNoValues(whereHappend: this.runtimeType))
        : Result.ok(_byId.values);
    /// Returns Result.fail if there is no elements(entries) in data
    Result<Iterable<MapEntry<String, T>>> tryGetEntries() => isEmpty 
        ? Result.fail(ErrorNoEntries(whereHappend: this.runtimeType))
        : Result.ok(_byId.entries);

    /// Returns length of data
    int get length => _byId.length;
    /// Returns null if there is no element with given [id] 
    T? operator [](String id) => _byId[id] ?? null;
    /// assigns value by id / creates if there was no such element
    void operator []=(String id, T value) => _byId[id] = value;

    Result<EntityRepo> operator +(T entity) {
        if(entity.id.trim().isEmpty || !isKnown(entity.id)) return Result.fail(ErrorEntityNotFound(entity));
        _byId[entity.id] = entity;
        return Result.ok(this);
    }
    Result<EntityRepo> operator -(T entity) {
        if(entity.id.trim().isEmpty || !isKnown(entity.id)) return Result.fail(ErrorEntityNotFound(entity));
        _byId.remove(entity.id);
        return Result.ok(this);
    }

    void clear() => _byId.clear();
    Iterable<T> where(bool Function(T) pred) => _byId.values.where(pred);
}

/* 

    bool isKnown(String id) => !isUndefined(id) && !isNull(id) ? true : false;
    bool isUndefined(String id) => !_byId.containsKey(id) ? true : false;
    bool isNull(String id) => _byId[id] == null ? true : false;
    Iterable<String> ids() => _byId.keys;
    Iterable<T> values() => _byId.values;
    Iterable<MapEntry<String, T>> entries() => _byId.entries;
    int get length => _byId.length;
    T? operator [](String id) => _byId[id] ?? null;
    void operator []=(String id, T value) => _byId[id] = value;


 */
















