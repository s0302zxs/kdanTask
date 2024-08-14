import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

@freezed
class Failure with _$Failure {
  const factory Failure.noNetwork() = _noNetwork;
  const factory Failure.apiException(
      int statusCode, Object exception, StackTrace stackTrace) = _apiException;
  const factory Failure.exception(Object exception, StackTrace stackTrace) =
  _exception;
  const factory Failure.badRequest() = _badRequest;
  const factory Failure.authorizeFailed() = _authorizeFailed;
  const factory Failure.forbidden() = _forbidden;
  const factory Failure.accountNotFound() = _accountNotFound;
  const factory Failure.selectingImageTooLarge(String size) =
  _selectingImageTooLarge;

  // FirebaseAuthException
  const factory Failure.firebaseException(
      String? message,
      String code,
      StackTrace? stackTrace,
      ) = _firebaseException;
}
