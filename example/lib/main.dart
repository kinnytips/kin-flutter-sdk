import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:kinny/kin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _accountId = 'Unknown';
  Kin kin = Kin(isProduction: false);
  @override
  void initState() {
    super.initState();
    createAccountOnBlocChain();
  }

  Future<void> createAccountOnBlocChain() async {
    await kin.createAccount();
    String accountId = kin.accountId;
    if (!mounted) return;
    setState(() {
      _accountId = accountId;
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
          child: Text('Running on: $_accountId\n'),
        ),
      ),
    );
  }
}
