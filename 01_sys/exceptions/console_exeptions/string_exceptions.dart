import '../../color.dart';
import '../domain_error.dart';

class StringIsNull extends DomainError{
    StringIsNull(String str)
        : super(
            code: "GIVEN_STRING_IS_NULL",
            context: {"str": str},
        );
}
class NoPrefixFound extends DomainError{
    NoPrefixFound(String str, String prefix)
        : super(
            code: "NO_PREFIX_WAS_FOUND",
            errorDescription: "${Color.red} Couldn't find prefix in the given string.",
            context: {
                "str": str,
                "prefix": prefix,
            },
        );
}
class FlagsNotFound extends DomainError{
    FlagsNotFound(String str, String prefix)
        : super(
            code: "FLUGS_NOT_FOUND",
            context: {
                "str": str,
                "prefix": prefix,
             },
        );
}
