import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kin_sdk_example/help/Constants.dart';

class TestTransactionLatency extends StatefulWidget {
  @override
  _testTransactionLatencyState createState() => _testTransactionLatencyState();
}

class _testTransactionLatencyState extends State<TestTransactionLatency> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(kinDemo),
        titleSpacing: 0.2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: destinationAddress),
                  )
                ],
              ),
              Container(
                width: double.infinity,
                height: 50,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  onPressed: () {},
                  color: appBlueColor,
                  child: Text(
                    sendKin,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'medium',
                        fontSize: 18),
                  ),
                ),
              )
            ]),
      ),
    );
  }
}
