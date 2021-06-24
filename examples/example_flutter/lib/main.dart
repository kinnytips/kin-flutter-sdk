import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:kin_base/kin.dart';
import 'package:path_provider/path_provider.dart';

import 'app/app.dart';
import 'common/bloc/simple_bloc_observer.dart';
import 'common/constants/env.dart';

void main() async {
  Bloc.observer = SimpleBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();

  var storeDir = await getApplicationSupportDirectory();

  var storePath = storeDir.path ;

  var kin = Kin(true, 0, 'KIN Demo App - Flutter', storageLocation: '$storePath/kin-demo-app', initialize: false);

  var app = App(kin: kin);

  runApp(app);
}