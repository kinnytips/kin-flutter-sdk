import 'package:flutter/material.dart';
import 'package:kin_base/base/models/kin_account.dart';
import 'package:kin_base/kin.dart';
import 'package:kin_sdk_example_flutter/common/constants/env.dart';

class App extends StatefulWidget {
  final Kin kin;

  App({Key key, @required this.kin}) : super(key: key);

  @override
  _AppState createState() => _AppState(kin);
}

class _AppState extends State<App> {
  final Kin kin ;

  _AppState(this.kin);

  KinAccountId get accountId => kin.getKinContext()?.accountId ;

  String get accountIdStellarBase32 => accountId?.stellarBase32Encode() ?? '?' ;

  var homeNavigator = GlobalKey<NavigatorState>();

  @override
  void initState() {
    print('--- initState');
    print(kin);

    kin.waitReady().then((value) {
      refresh();
    });

    kin.initialize();

    super.initState();
  }

  void refresh() {
    setState(() {});
  }

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
              title: Text( kin.isReady ? 'Loading...' : 'Account: $accountIdStellarBase32' ),
              onTap: (() => 1),
            ),
            ListTile(
              title: Text('Backup Wallet', style: TextStyle(
                color: Colors.purple,
                fontWeight: FontWeight.bold,
                fontSize: 20),
                textAlign: TextAlign.center,
              ),
              onTap: (backupWallet),
            )
          ],
        ),
      ),
    );
  }

  void backupWallet() {

  }
}
