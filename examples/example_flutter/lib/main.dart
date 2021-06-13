import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:kin_base/base/models/solana/transaction.dart';
import 'dart:async';

import 'package:kin_base/kin.dart';
import 'package:kin_base/models/app/interfaces/status.dart';

import 'app/app.dart';
import 'common/constants/env.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App(env: EnvValue.production));
}