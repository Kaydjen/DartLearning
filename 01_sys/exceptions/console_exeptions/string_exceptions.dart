import '../../color.dart';
import '../domain_error.dart';

class StringIsNull extends DomainError{
    StringIsNull()
        : super(
            code: "GIVEN_STRING_IS_NULL",
            errorDescription: "${Color.set(ColorTypes.brightCyan)} "
        );
}
