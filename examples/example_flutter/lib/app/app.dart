import 'package:flutter/material.dart';
import 'package:kin_sdk_example_flutter/common/constants/env.dart';

class App extends StatefulWidget {
  final Env env;

  App({Key key, @required this.env}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  var homeNavigator = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
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
              title: Text('GDV4TKOCDBHB3XGCKAXWYETQRIN4RTJKSD6FQV43E2AUHORR56B4YDC4'),
              onTap: (() => 1),
            ),
            ListTile(
              title: Text('GAJYDRZZD6ST37NQ3NA562RFY2RAZACNZJOKETV3F2A6N6IITSBIEGQF'),
              onTap: (() => 1),
            ),
            ListTile(
              title: Text('GAWQUKB2KMSCCUSJ7IQHI6FDUAEOXVW2HRHD7VEVDN2HDCBJBGRVLZZJ'),
              onTap: (() => 1),
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
