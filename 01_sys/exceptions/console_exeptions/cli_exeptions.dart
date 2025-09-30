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
class IDNotAccessible extends DomainError {
    IDNotAccessible()
        : super(
            code: "ID_NOT_ACCESSIBLE",
            errorDescription: "Tried to access ID, but it's not set.",
        );
}
class FlagsNotAccessible extends DomainError {
    FlagsNotAccessible()
        : super(
            code: "FLAGS_NOT_ACCESSIBLE",
            errorDescription: "Tried to access flags' map in CliOptions, but it's not set.",
        );
}