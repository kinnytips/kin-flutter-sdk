import 'package:flutter/widgets.dart';
import 'package:kin_base/base/kin_account_context.dart';
import 'package:kin_base/base/models/kin_balance.dart';
import 'package:kin_base/base/tools/observers.dart';
import 'package:kin_sdk_example_flutter/common/constants/env.dart';
import 'package:kin_sdk_example_flutter/models/home_page_info.dart';
import 'package:kin_sdk_example_flutter/network/response.dart';

class HomeService {
  HomeService({@required this.env})
  {
    context = KinAccountContextBuilder(env.environment).createNewAccount();
  }

  KinAccountContext context;
  Env env;

  Future<DataResponse<HomePageInfo>> fetchHomePageInfo() async {
    final response = await _fetchHomePageInfo();

    if (response == null) {
      return DataResponse.connectivityError();
    }
  }

  Future<Observer<KinBalance>> _fetchHomePageInfo() async {
    //TODO: SET KIN ACCOUNTS
    
    return await context.observeBalance();
  }
}