import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kin_sdk_example_flutter/common/bloc/home_state.dart';
import 'package:kin_sdk_example_flutter/common/routes/routes.dart';
import 'package:kin_sdk_example_flutter/models/home_page_info.dart';

class HomeWidget extends StatefulWidget {
  var homeNavigator = GlobalKey<NavigatorState>();

  HomeWidget({Key key}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  Completer<void> _refreshCompleter;

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
  }

  @override
  Widget build(BuildContext context1) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeEmptyState) {
          return Container(
          );
        }
        if (state is HomeErrorState) {
          return Center(
            child: Text(
              "Could not load home page, please try again later",
              style: TextStyle(color: Colors.white),
            ),
          );
        }
        if (state is HomeLoadingInBackgroundState) {
          return _getLoadedHomePage(state.info);
        }
        if (state is HomeLoadedState) {
          _refreshCompleter?.complete();
          _refreshCompleter = Completer();
          return _getLoadedHomePage(state.info);
        }
        return Container(
        );
      },
    );
  }

  Widget _getLoadedHomePage(HomePageInfo info) {
    return WillPopScope(
      onWillPop: () async {
        if (widget.homeNavigator.currentState.canPop()) {
          widget.homeNavigator.currentState.pop();
          return false;
        } else
          return true;
      },
      child: Scaffold(
        body: Navigator(
            key: widget.homeNavigator,
            onGenerateRoute: (settings) {
              switch (settings.name) {
                case Routes.receiveKin:
                  return _getReceiveKinPage(info);
                case Routes.sendKin:
                  return _getSendKinPage(info);
                case Routes.viewAccount:
                  return _viewAccount(info);
                case Routes.viewInvoices:
                  return _viewInvoices(info);
                case Routes.testTransactionLatency:
                  return _testTransactionLatency(info);
                case Routes.fundAccount:
                  return _fundAccount(info);
                case Routes.deleteAccount:
                  return _deleteAccount(info);
                case Routes.history:
                  return _history(info);
                default:
                  return _getDefaultHomePage(info);
              }
            }),
      ),
    );
  }

  MaterialPageRoute _getDefaultHomePage(HomePageInfo info) {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
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

  MaterialPageRoute _getReceiveKinPage(HomePageInfo info) {
    return MaterialPageRoute(
    );
  }

  MaterialPageRoute _getSendKinPage(HomePageInfo info) {
    return MaterialPageRoute(
    );
  }

  MaterialPageRoute _viewAccount(HomePageInfo info) {
    return MaterialPageRoute(
    );
  }

  MaterialPageRoute _viewInvoices(HomePageInfo info) {
    return MaterialPageRoute(
    );
  }

  MaterialPageRoute _testTransactionLatency(HomePageInfo info) {
    return MaterialPageRoute(
    );
  }

  MaterialPageRoute _fundAccount(HomePageInfo info) {
    return MaterialPageRoute(
    );
  }

  MaterialPageRoute _deleteAccount(HomePageInfo info) {
    return MaterialPageRoute(
    );
  }

  MaterialPageRoute _history(HomePageInfo info) {
    return MaterialPageRoute(
    );
  }
}
