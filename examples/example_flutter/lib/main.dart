import 'package:flutter/material.dart';
import 'package:kin_base/base/models/solana/transaction.dart';
import 'dart:async';

import 'package:kin_base/kin.dart';
import 'package:kin_base/models/app/interfaces/status.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _output = 'Unknown';
  // Kin kin = Kin(isProduction: false);
  @override
  void initState() {
    super.initState();
    // createAccountOnBlocChain();
  }

  // Future<void> createAccountOnBlocChain() async {
  //   var response = await kin.createAccount();
  //   String output;
  //   if (response.operationStatus.result == Result.FAIL) {
  //     output = response.operationStatus.message;
  //   } else {
  //     output = kin.accountId;
  //   }
  //   if (!mounted) return;
  //   setState(() {
  //     _output = output;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Kin SDK Demo'),
        ),
        body: ListView(
          children: <Widget>[
            
            ListTile(
              title: Text('GDV4TKOCDBHB3XGCKAXWYETQRIN4RTJKSD6FQV43E2AUHORR56B4YDC4'),
            ),
            ListTile(
              title: Text('GAJYDRZZD6ST37NQ3NA562RFY2RAZACNZJOKETV3F2A6N6IITSBIEGQF'),
            ),
            ListTile(
              title: Text('GAWQUKB2KMSCCUSJ7IQHI6FDUAEOXVW2HRHD7VEVDN2HDCBJBGRVLZZJ'),
            ),
            ListTile(
              title: Text('Create New Wallet', style: TextStyle(
                color: Colors.purple,
                fontWeight: FontWeight.bold,
                fontSize: 20),
                textAlign: TextAlign.center,
              ),
              onTap: (() => 1),
            )
          ],
        ),
      ),
    );
  }
}
