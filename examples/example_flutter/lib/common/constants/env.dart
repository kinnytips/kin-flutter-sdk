import 'package:kin_base/base/kin_environment.dart';

class Env {
  KinEnvironment environment;
}

mixin EnvValue {
  static final Env testKin3 = Env();
  static final Env testKin4 = Env();
}