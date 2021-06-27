import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kin_base/base/models/kin_account.dart';
import 'package:kin_base/kin.dart';
import 'package:kin_sdk_example_flutter/common/bloc/home/home_bloc.dart';
import 'package:kin_sdk_example_flutter/common/bloc/home/home_state.dart';
import 'package:kin_sdk_example_flutter/common/routes/routes.dart';
import 'package:kin_sdk_example_flutter/models/home_page_info.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeWidget extends StatefulWidget {
  var homeNavigator = GlobalKey<NavigatorState>();
    final Kin kin;

  HomeWidget({Key key, this.kin}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState(kin);
}

class _HomeWidgetState extends State<HomeWidget> {
  final Kin kin;

  KinAccountId accountId;

  _HomeWidgetState(this.kin);

  String get accountIdStellarBase32 => accountId?.stellarBase32Encode() ?? '?';

  @override
  void initState() {
    print('--- initState');
    print(kin);

    ensurePermissions().then((ok) {
      print('-- Permissions: $ok');

      kin.waitReady().then((ready) {
        print('-- KIN Ready: $ready ; $kin');

        setState(() {
          accountId = kin.getKinContext().accountId;
        });
      });

      print('-- KIN initialize');
      kin.initialize();
    });

    super.initState();
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
          return _getLoadedHomePage(state.info);
        }
        return Container(
        );
      },
    );
  }

  Future<bool> ensurePermissions() async {
    var status = await Permission.storage.status;

    if (!status.isGranted) {
      status = await Permission.storage.request();
    }

    return status.isGranted;
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
    var accountText =
        kin.isNotReady ? 'Loading...' : 'Account:\n$accountIdStellarBase32';

    return MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: const Text('Kin SDK Demo'),
        ),
        body: ListView(
          children: <Widget>[
            
            ListTile(
              title: Text(
                accountText,
                textAlign: TextAlign.center,
                ),
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
