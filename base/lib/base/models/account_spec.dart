///
/// A spec for how to interpret a set of accounts.
///
enum AccountSpec {
  /// Use the EXACT account address specified and only that. Fail otherwise.
  Exact,

  /// PREFER to use the account address I specify, but if that does not exist,
  /// resolve the tokenAccounts for this account and use the first one.
  Preferred,
}
