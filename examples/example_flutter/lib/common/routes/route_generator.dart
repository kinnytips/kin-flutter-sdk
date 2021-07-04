import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kin_sdk_example_flutter/widget/home/home_page.dart';

import 'routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute<dynamic>(builder: (_) => HomePage());
      case Routes.deleteAccount:
        return MaterialPageRoute<dynamic>(builder: (_) => DeleteAccountPage());
      case Routes.fundAccount:
        return MaterialPageRoute<dynamic>(builder: (_) => FundAccountPage());
      case Routes.history:
        return MaterialPageRoute<dynamic>(builder: (_) => HistoryPage());
      case Routes.receiveKin:
        return MaterialPageRoute<dynamic>(builder: (_) => ReceiveKinPage());
      case Routes.sendKin:
        return MaterialPageRoute<dynamic>(builder: (_) => SendKinPage());
      case Routes.testTransactionLatency:
        return MaterialPageRoute<dynamic>(builder: (_) => TestTransactionLatencyPage());
      case Routes.viewAccount:
        return MaterialPageRoute<dynamic>(builder: (_) => ViewAccountPage());
      case Routes.viewInvoices:
        return MaterialPageRoute<dynamic>(builder: (_) => ViewInvoicesPage());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute<dynamic>(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
