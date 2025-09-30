import '../domain_error.dart';

class NoFuncForId extends DomainError {
    NoFuncForId(int id)
        : super(
            code: "NO_FUNC_FOR_ID",
            context: {
                "id": id,
            },
        );
}

class NoSuchId extends DomainError {
    NoSuchId(int id)
        : super(
            code: "NO_SUCH_ID",
            context: {
                "id": id,
            },
        );
}