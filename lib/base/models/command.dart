abstract class Command {
  final int value;

  Command(this.value);
}


class Assign extends Command {
  Assign() : super(1);
}

class Transfer extends Command {
  Transfer() : super(2);
}

class CreateAccountWithSeed extends Command {
  CreateAccountWithSeed() : super(3);
}

class AdvanceNonceAccount extends Command {
  AdvanceNonceAccount() : super(4);
}

class WithdrawNonceAccount extends Command {
  WithdrawNonceAccount() : super(5);
}


class InitializeNonceAccount extends Command {
  InitializeNonceAccount() : super(6);
}

class AuthorizeNonceAccount extends Command {
  AuthorizeNonceAccount() : super(7);
}

class Allocate extends Command {
  Allocate() : super(8);
}

class AllocateWithSeed extends Command {
  AllocateWithSeed() : super(9);
}

class AssignWithSeed extends Command {
  AssignWithSeed() : super(10);
}

class TransferWithSeed extends Command {
  TransferWithSeed() : super(11);
}









