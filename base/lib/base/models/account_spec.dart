///
/// A spec for how to interpret a set of accounts.
///
class AccountSpec {
  final int value;

  AccountSpec(this.value);
}

///
/// Use the EXACT account address specified and only that. Fail otherwise.
///
class Exact extends AccountSpec {
  Exact() : super(0);
}

///
/// PREFER to use the account address I specify, but if that does not exist,
/// resolve the tokenAccounts for this account and use the first one.
///
class Preferred extends AccountSpec {
  Preferred() : super(1);
}
