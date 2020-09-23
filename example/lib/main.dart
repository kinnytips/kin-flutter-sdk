import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kin_sdk_example/ui/kin_sdk_id.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: KinSdkId(),
    );
  }
}