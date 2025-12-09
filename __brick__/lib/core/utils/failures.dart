/// Base class for all failures in the application.
///
/// Failures represent expected error conditions that can occur during
/// normal application operation. They should be handled gracefully.
sealed class Failure {
  const Failure([this.message]);

  final String? message;

  @override
  String toString() => message ?? 'An error occurred';
}

/// Failure that occurs when a network request fails.
///
/// This includes:
/// - No internet connection
/// - Timeout
/// - Connection refused
/// - DNS resolution failure
final class NetworkFailure extends Failure {
  const NetworkFailure([super.message]);

  @override
  String toString() =>
      message ??
      'Network connection failed. Please check your internet connection.';
}

/// Failure that occurs when the server returns an error (5xx status codes).
final class ServerFailure extends Failure {
  const ServerFailure([super.message]);

  @override
  String toString() =>
      message ?? 'Server error occurred. Please try again later.';
}

/// Failure that occurs when the client request is invalid (4xx status codes).
final class ClientFailure extends Failure {
  const ClientFailure([super.message]);

  @override
  String toString() => message ?? 'Invalid request. Please check your input.';
}

/// Failure that occurs when the requested resource is not found (404).
final class NotFoundFailure extends Failure {
  const NotFoundFailure([super.message]);

  @override
  String toString() => message ?? 'The requested resource was not found.';
}

/// Failure that occurs when authentication is required or has failed (401).
final class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure([super.message]);

  @override
  String toString() => message ?? 'Authentication required. Please log in.';
}

/// Failure that occurs when access to a resource is forbidden (403).
final class ForbiddenFailure extends Failure {
  const ForbiddenFailure([super.message]);

  @override
  String toString() => message ?? 'Access to this resource is forbidden.';
}

/// Failure that occurs during local data operations (cache, database, etc).
final class CacheFailure extends Failure {
  const CacheFailure([super.message]);

  @override
  String toString() => message ?? 'Failed to access local data.';
}

/// Failure that occurs when data validation fails.
final class ValidationFailure extends Failure {
  const ValidationFailure([super.message]);

  @override
  String toString() => message ?? 'Data validation failed.';
}

/// Failure that occurs when data parsing fails.
final class ParsingFailure extends Failure {
  const ParsingFailure([super.message]);

  @override
  String toString() => message ?? 'Failed to parse data.';
}

/// Generic failure for unexpected errors.
final class UnexpectedFailure extends Failure {
  const UnexpectedFailure([super.message]);

  @override
  String toString() => message ?? 'An unexpected error occurred.';
}
