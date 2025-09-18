import 'domain_error.dart';

class Result<T> {
  final T? value;
  final DomainError? error;

  Result._({this.value, this.error});

  bool get isSuccess => error == null;

  static Result<T> ok<T>(T value) => Result._(value: value);
  static Result<T> fail<T>(DomainError error) => Result._(error: error);
}