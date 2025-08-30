
abstract class DomainExeption implements Exception {
  final String message;
  DomainExeption(this.message);

  @override
  String toString() => "$runtimeType: $message";
}