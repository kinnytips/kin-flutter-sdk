import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:kin_sdk/kin_sdk.dart';
import 'package:kin_sdk/models/application/kin_binary_memo.dart';
import 'package:kin_sdk/models/application/kin_binary_memo.dart';
import 'package:kin_sdk/models/application/kin_helper.dart';
import 'package:kin_sdk/models/kin_memo.dart';

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
    KinSdk sdk =
        KinSdk("GDHCB4VCNNFIMZI3BVHLA2FVASECBR2ZXHOAXEBBFVUH5G2YAD7V3JVH");
    try {
      var response = await sdk.createAccount;
      if (response.isSuccess)
        accountId = response.accountInfo.accountId.toString();
      else
        accountId = "Failure";
    } on PlatformException {
      accountId = 'Failed to get accountId';
    }

    if (!mounted) return;

    setState(() {
      _accountId = accountId;
    });

    KinMemo memo = (KinBuilder(1)
          ..setForeginKey(Base64Decoder()
              .convert("LlGNZRHhFnMcDk3/oZ62OsPrRXjv0M2sk9YTIAA="))
          ..setTransferType(TransferType.earn))
        .build()
        .toKinMemo();

    print(memo.toString());

    KinHelper.encode();
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
            )
          ],
        ),
      ),
    );
  }
}
