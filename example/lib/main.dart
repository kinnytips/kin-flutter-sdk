import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:kin_sdk/kin_sdk.dart';
import 'package:kin_sdk/kin_base_compat_sdk.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _accountId = 'No account id';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String accountId;
    KinSdk sdk = KinSdk.newAccount(
        1,
        "GDHCB4VCNNFIMZI3BVHLA2FVASECBR2ZXHOAXEBBFVUH5G2YAD7V3JVH",
        "Kinny App",
        0,
        "demo_app_uid",
        "demo_app_user_passkey");
    try {
      accountId = await sdk.createAccount;
    } on PlatformException {
      accountId = 'Failed to get accountId';
    }

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
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            Center(
              child: Text('Base : $_accountId\n'),
            ),
          ],
        ),
      ),
    );
  }
}
