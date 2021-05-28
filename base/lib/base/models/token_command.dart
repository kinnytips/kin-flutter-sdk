abstract class TokenCommand {
  final int value;

  TokenCommand(this.value);
}

class InitializeMint extends TokenCommand {
  InitializeMint() : super(0);
}

class InitializeAccount extends TokenCommand {
  InitializeAccount() : super(1);
}

class InitializeMultisig extends TokenCommand {
  InitializeMultisig() : super(2);
}

class Transfer extends TokenCommand {
  Transfer() : super(3);
}

class Approve extends TokenCommand {
  Approve() : super(4);
}

class Revoke extends TokenCommand {
  Revoke() : super(5);
}

class SetAuthority extends TokenCommand {
  SetAuthority() : super(6);
}

class MintTo extends TokenCommand {
  MintTo() : super(7);
}

class Burn extends TokenCommand {
  Burn() : super(8);
}

class CloseAccount extends TokenCommand {
  CloseAccount() : super(9);
}

class FreezeAccount extends TokenCommand {
  FreezeAccount() : super(10);
}

class ThawAccount extends TokenCommand {
  ThawAccount() : super(11);
}

class Transfer2 extends TokenCommand {
  Transfer2() : super(12);
}

class Approve2 extends TokenCommand {
  Approve2() : super(13);
}

class MintTo2 extends TokenCommand {
  MintTo2() : super(14);
}

class Burn2 extends TokenCommand {
  Burn2() : super(15);
}
