abstract class AuthorityType {
  final int value;

  AuthorityType(this.value);
}

class AuthorityTypeMintTokens extends AuthorityType {
  AuthorityTypeMintTokens() : super(0);
}

class AuthorityFreezeAccount extends AuthorityType {
  AuthorityFreezeAccount() : super(1);
}

class AuthorityAccountHolder extends AuthorityType {
  AuthorityAccountHolder() : super(2);
}

class AuthorityCloseAccount extends AuthorityType {
  AuthorityCloseAccount() : super(3);
}
