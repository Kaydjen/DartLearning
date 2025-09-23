
import '../domain_error.dart';

class IndexOutOfRange extends DomainError{
    IndexOutOfRange(String listName, int index)
        : super(
            code: "INDEX_OUT_OF_RANGE",
            context: {
                "listName": listName,
                "index": index
             },
        );
}
