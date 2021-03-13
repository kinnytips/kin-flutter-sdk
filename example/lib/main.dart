import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:kinny/kin.dart';
import 'package:kinny/models/app/interfaces/status.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _output = 'Unknown';
  Kin kin = Kin(isProduction: false);
  @override
  void initState() {
    super.initState();
    createAccountOnBlocChain();
  }

  Future<void> createAccountOnBlocChain() async {
    var response = await kin.createAccount();
    String output;
    if (response.operationStatus.result == Result.FAIL) {
      output = response.operationStatus.message;
    } else {
      output = kin.accountId;
    }
    if (!mounted) return;
    setState(() {
      _output = output;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Example app to test Kin SDK'),
        ),
        body: Center(
          child: Text('Result : $_output\n'),
        ),
      ),
    );
  }
}
