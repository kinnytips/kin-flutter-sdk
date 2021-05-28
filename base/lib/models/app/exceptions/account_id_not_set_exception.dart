///
/// `AccountIdNotSetException` occurs when the an operation is requested that requires
/// `accountId` to be present in the context but is not present.
///
/// This exception needs to be handled in the client side.
class AccountIdNotSetException implements Exception {
  String cause;
  AccountIdNotSetException(this.cause);
}
