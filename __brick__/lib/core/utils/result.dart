/// A type that represents either success or failure.
sealed class Result<S, F> {
  const Result();

  /// Returns true if the result is a success.
  bool get isSuccess => this is Success<S, F>;

  /// Returns true if the result is a failure.
  bool get isFailure => this is Failure<S, F>;

  /// Returns the success value or null if this is a failure.
  S? get successOrNull => switch (this) {
    Success(value: final value) => value,
    Failure() => null,
  };

  /// Returns the failure value or null if this is a success.
  F? get failureOrNull => switch (this) {
    Success() => null,
    Failure(error: final error) => error,
  };

  /// Transforms the success value using the given function.
  Result<R, F> map<R>(R Function(S) transform) {
    return switch (this) {
      Success(value: final value) => Success(transform(value)),
      Failure(error: final error) => Failure(error),
    };
  }

  /// Transforms the failure value using the given function.
  Result<S, R> mapFailure<R>(R Function(F) transform) {
    return switch (this) {
      Success(value: final value) => Success(value),
      Failure(error: final error) => Failure(transform(error)),
    };
  }

  /// Executes different callbacks based on whether this is a success or failure.
  R when<R>({required R Function(S) success, required R Function(F) failure}) {
    return switch (this) {
      Success(value: final value) => success(value),
      Failure(error: final error) => failure(error),
    };
  }
}

/// Represents a successful result containing a value.
final class Success<S, F> extends Result<S, F> {
  const Success(this.value);

  final S value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Success &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'Success($value)';
}

/// Represents a failed result containing an error.
final class Failure<S, F> extends Result<S, F> {
  const Failure(this.error);

  final F error;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Failure &&
          runtimeType == other.runtimeType &&
          error == other.error;

  @override
  int get hashCode => error.hashCode;

  @override
  String toString() => 'Failure($error)';
}
