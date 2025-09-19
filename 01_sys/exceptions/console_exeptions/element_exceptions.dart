
import '../domain_error.dart';

class ElementIsEmpty extends DomainError{
    ElementIsEmpty(String emptyElement, Object place)
        : super(
            code: "ELEMENT_IS_EMPTY",
            context: {
                "emptyElement": emptyElement,
             },
            place: place,
        );
}
class ElementsAreEmpty extends DomainError{
    ElementsAreEmpty(List<String> emptyElementsNames, Object place)
        : super(
            code: "ELEMENTS_ARE_EMPTY",
            context: {
                "emptyElementsNames": emptyElementsNames,
             },
            place: place,
        );
}
