import 'package:flutter/material.dart';
import 'package:kin_sdk_example/Constants.dart';

class KinWallet extends StatefulWidget {
  String kinId;

  KinWallet({this.kinId});

  @override
  _KinWalletState createState() => _KinWalletState();
}

class _KinWalletState extends State<KinWallet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(kinWallet),
          titleSpacing: 0.2,
        ),
        body: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(20.0),
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/kin_logo.png',
                  height: 20,
                  width: 20,
                ),
                Text(
                  '10000',
                  style: TextStyle(
                    fontSize: 40.0,
                    fontFamily: 'semi_bold',
                    color: Colors.black,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              widget.kinId,
              style: TextStyle(
                fontSize: 15.0,
                fontFamily: 'regular',
                color: appGreyColor,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              copyWalletAddress,
              style: TextStyle(
                fontSize: 18.0,
                fontFamily: 'medium',
                color: appBlackColor,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              sendKin,
              style: TextStyle(
                fontSize: 18.0,
                fontFamily: 'medium',
                color: appBlackColor,
              ),
            ),
            Text(
              transferKin,
              style: TextStyle(
                fontSize: 17.0,
                fontFamily: 'regular',
                color: appGreyColor,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              invoices,
              style: TextStyle(
                fontSize: 18.0,
                fontFamily: 'medium',
                color: appBlackColor,
              ),
            ),
            Text(
              createDemo,
              style: TextStyle(
                fontSize: 17.0,
                fontFamily: 'regular',
                color: appGreyColor,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              testTransaction,
              style: TextStyle(
                fontSize: 18.0,
                fontFamily: 'medium',
                color: appBlackColor,
              ),
            ),
            Text(
              performRepeated,
              style: TextStyle(
                fontSize: 17.0,
                fontFamily: 'regular',
                color: appGreyColor,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              fundWallet,
              style: TextStyle(
                fontSize: 18.0,
                fontFamily: 'medium',
                color: appBlackColor,
              ),
            ),
            Text(
              fundTheWallet,
              style: TextStyle(
                fontSize: 17.0,
                fontFamily: 'regular',
                color: appGreyColor,
              ),
            ),
            SizedBox(
              height: 35,
            ),
            Text(
              deleteWallet,
              style: TextStyle(
                fontSize: 18.0,
                fontFamily: 'medium',
                color: appRedColor,
              ),
            ),
            SizedBox(
              height: 35,
            ),
            Text(
              history,
              style: TextStyle(
                fontSize: 18.0,
                fontFamily: 'medium',
                color: appGreyColor,
              ),
            ),
          ],
        ));
  }
}
