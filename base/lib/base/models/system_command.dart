abstract class SystemCommand {
  final int value;

  SystemCommand(this.value);
}

class CreateAccount extends SystemCommand {
  CreateAccount() : super(0);
}

class Assign extends SystemCommand {
  Assign() : super(1);
}

class Transfer extends SystemCommand {
  Transfer() : super(2);
}

class CreateAccountWithSeed extends SystemCommand {
  CreateAccountWithSeed() : super(3);
}

class AdvanceNonceAccount extends SystemCommand {
  AdvanceNonceAccount() : super(4);
}

class WithdrawNonceAccount extends SystemCommand {
  WithdrawNonceAccount() : super(5);
}

class InitializeNonceAccount extends SystemCommand {
  InitializeNonceAccount() : super(6);
}

class AuthorizeNonceAccount extends SystemCommand {
  AuthorizeNonceAccount() : super(7);
}

class Allocate extends SystemCommand {
  Allocate() : super(8);
}

class AllocateWithSeed extends SystemCommand {
  AllocateWithSeed() : super(9);
}

class AssignWithSeed extends SystemCommand {
  AssignWithSeed() : super(10);
}

class TransferWithSeed extends SystemCommand {
  TransferWithSeed() : super(11);
}
