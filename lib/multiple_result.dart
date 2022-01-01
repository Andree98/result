library multiple_result;

import 'package:meta/meta.dart';

/// Base Result class
///
/// Receives two values [F] and [S]
/// as [F] is a failure and [S] is a success.
@sealed
abstract class Result<F, S> {
  /// Default constructor.
  const Result();

  /// Returns the current result.
  ///
  /// It may be a [Success] or an [Failure].
  /// Check with
  /// ```dart
  ///   result.isSuccess();
  /// ```
  /// or
  /// ```dart
  ///   result.isFailure();
  /// ```
  ///
  /// before casting the value;
  dynamic get();

  /// Returns the value of [S].
  S? getSuccess();

  /// Returns the value of [F].
  F? getFailure();

  /// Returns true if the current result is a [Failure].
  bool isFailure();

  /// Returns true if the current result is a [success].
  bool isSuccess();

  /// Return the result in one of these functions.
  ///
  /// if the result is a failure, it will be returned in
  /// [whenFailure],
  /// if it is a success it will be returned in [whenSuccess].
  W when<W>(
    W Function(F failure) whenFailure,
    W Function(S success) whenSuccess,
  );
}

/// Success Result.
///
/// return it when the result of a [Result] is
/// the expected value.
@immutable
class Success<F, S> implements Result<F, S> {
  /// Receives the [S] param as
  /// the successful result.
  const Success(
    this._success,
  );

  final S _success;

  @override
  S get() {
    return _success;
  }

  @override
  bool isFailure() => false;

  @override
  bool isSuccess() => true;

  @override
  int get hashCode => _success.hashCode;

  @override
  bool operator ==(Object other) =>
      other is Success && other._success == _success;

  @override
  W when<W>(
    W Function(F failure) whenFailure,
    W Function(S success) whenSuccess,
  ) {
    return whenSuccess(_success);
  }

  @override
  F? getFailure() => null;

  @override
  S? getSuccess() => _success;
}

/// Failure Result.
///
/// return it when the result of a [Result] is
/// not the expected value.
@immutable
class Failure<F, S> implements Result<F, S> {
  /// Receives the [F] param as
  /// the failure result.
  const Failure(this._failure);

  final F _failure;

  @override
  F get() {
    return _failure;
  }

  @override
  bool isFailure() => true;

  @override
  bool isSuccess() => false;

  @override
  int get hashCode => _failure.hashCode;

  @override
  bool operator ==(Object other) => other is Failure && other._failure == _failure;

  @override
  W when<W>(
    W Function(F failure) whenFailure,
    W Function(S succcess) whenSuccess,
  ) {
    return whenFailure(_failure);
  }

  @override
  F? getFailure() => _failure;

  @override
  S? getSuccess() => null;
}

/// Default success class.
///
/// Instead of returning void, as
/// ```dart
///   Result<Exception, void>
/// ```
/// return
/// ```dart
///   Result<Exception, SuccessResult>
/// ```
class SuccessResult {
  const SuccessResult._internal();
}

/// Default success case.
const success = SuccessResult._internal();
