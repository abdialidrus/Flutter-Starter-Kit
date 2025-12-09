import 'package:flutter_test/flutter_test.dart';
import 'package:{{project_name.snakeCase()}}/core/utils/result.dart';

void main() {
  group('Result', () {
    group('Success', () {
      test('should create a success result with value', () {
        const result = Success<int, String>(42);

        expect(result.isSuccess, true);
        expect(result.isFailure, false);
        expect(result.successOrNull, 42);
        expect(result.failureOrNull, null);
      });

      test('should map success value', () {
        const result = Success<int, String>(42);
        final mapped = result.map((value) => value * 2);

        expect(mapped.isSuccess, true);
        expect(mapped.successOrNull, 84);
      });

      test('should not transform failure when mapping', () {
        const result = Success<int, String>(42);
        final mapped = result.mapFailure((error) => 'Error: $error');

        expect(mapped.isSuccess, true);
        expect(mapped.successOrNull, 42);
      });

      test('should execute success callback in when', () {
        const result = Success<int, String>(42);
        final output = result.when(
          success: (value) => 'Success: $value',
          failure: (error) => 'Failure: $error',
        );

        expect(output, 'Success: 42');
      });

      test('should be equal to another success with same value', () {
        const result1 = Success<int, String>(42);
        const result2 = Success<int, String>(42);

        expect(result1, result2);
        expect(result1.hashCode, result2.hashCode);
      });

      test('should have correct toString', () {
        const result = Success<int, String>(42);
        expect(result.toString(), 'Success(42)');
      });
    });

    group('Failure', () {
      test('should create a failure result with error', () {
        const result = Failure<int, String>('error');

        expect(result.isSuccess, false);
        expect(result.isFailure, true);
        expect(result.successOrNull, null);
        expect(result.failureOrNull, 'error');
      });

      test('should not transform success when mapping', () {
        const result = Failure<int, String>('error');
        final mapped = result.map((value) => value * 2);

        expect(mapped.isFailure, true);
        expect(mapped.failureOrNull, 'error');
      });

      test('should map failure value', () {
        const result = Failure<int, String>('error');
        final mapped = result.mapFailure((error) => 'Error: $error');

        expect(mapped.isFailure, true);
        expect(mapped.failureOrNull, 'Error: error');
      });

      test('should execute failure callback in when', () {
        const result = Failure<int, String>('error');
        final output = result.when(
          success: (value) => 'Success: $value',
          failure: (error) => 'Failure: $error',
        );

        expect(output, 'Failure: error');
      });

      test('should be equal to another failure with same error', () {
        const result1 = Failure<int, String>('error');
        const result2 = Failure<int, String>('error');

        expect(result1, result2);
        expect(result1.hashCode, result2.hashCode);
      });

      test('should have correct toString', () {
        const result = Failure<int, String>('error');
        expect(result.toString(), 'Failure(error)');
      });
    });
  });
}
