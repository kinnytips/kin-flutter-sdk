import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'app/app.dart';
import 'common/bloc/simple_bloc_observer.dart';
import 'common/constants/env.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App(env: EnvValue.production));
}