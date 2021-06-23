import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:kin_base/kin.dart';

import 'app/app.dart';
import 'common/bloc/simple_bloc_observer.dart';
import 'common/constants/env.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App(kin: Kin(true, 0, 'KIN Demo App - Flutter', initialize: false)));
}