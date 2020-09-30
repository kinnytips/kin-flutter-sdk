import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kin_sdk/base-compat/main/models/key_pair.dart';
import 'package:kin_sdk/kin_sdk.dart';
import 'package:kin_sdk_example/help/Constants.dart';

import 'kin_wallet.dart';

class KinSdkId extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<KinSdkId> {
  String _platformVersion;
  String _message;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;

    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await KinSdk.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
      KeyPair kp = KeyPair.random();
      _message = kp.accountId;
    });
  }

  void _btPress() {
    setState(() {
      KeyPair kp = KeyPair.random();
      _message = kp.accountId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Kin Flutter SDK Demo'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => KinWallet(
                          kinId: _message,
                        ),
                      ));
                },
                child: Text("ID:\n" + _message),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                importWallet,
                style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: 'medium',
                  color: appBlackColor,
                ),
              ),
              GestureDetector(
                onTap: () {
                  /* Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SendKin()),
                    );*/
                },
                child: Text(
                  restoreBackup,
                  style: TextStyle(
                    fontSize: 17.0,
                    fontFamily: 'regular',
                    color: appGreyColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _btPress,
          tooltip: 'Press',
          child: Icon(Icons.add_circle),
        ),
      ),
    );
  }
}