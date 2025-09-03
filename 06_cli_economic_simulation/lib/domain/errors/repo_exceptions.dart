import '../../app/appearance/color.dart';
import '../entities/entity.dart';
import 'domain_error.dart';

class ErrorIdNotFound extends DomainError{
    ErrorIdNotFound(String id, {Object? whereHappend})
        : super(
            code: "ID_NOT_FOUND",
            errorDescription: "${Color.set(ColorTypes.brightCyan)} There is no element with id "
            "${Color.set(ColorTypes.brightCyan, str: "[$id]", keepColor: false)} "
            "or it is empty.",
            context: {'id': id},
            place: whereHappend
        );
}
class ErrorEntityNotFound extends DomainError{
    ErrorEntityNotFound(Entity entity, {Object? whereHappend})
        : super(
            code: "ELEMENT_NOT_FOUND",
            errorDescription: "${Color.set(ColorTypes.brightCyan)} There is no such entity ",
            context: {'Entity': entity},
            place: whereHappend
        );
}
class ErrorNoKeys extends DomainError{
    ErrorNoKeys({Object? whereHappend})
        : super(
            code: "NO_KEYS",
            errorDescription: "There are no keys to iterate through",
            place: whereHappend
        );
}
class ErrorNoValues extends DomainError{
    ErrorNoValues({Object? whereHappend})
        : super(
            code: "NO_VALUES",
            errorDescription: "There are no value to iterate through",
            place: whereHappend
        );
}
class ErrorNoEntries extends DomainError{
    ErrorNoEntries({Object? whereHappend})
        : super(
            code: "NO_ELEMENTS_NO_ENTRIES",
            errorDescription: "There are no entries to iterate through",
            place: whereHappend
        );
}

/* 

class UserNotFoundError extends DomainError {-
  UserNotFoundError(String userId)
      : super(
          code: DomainErrorCode.userNotFound,
          errorDescription: 'Пользователь с ID $userId не найден',
          context: {'userId': userId},
        );
}
 */