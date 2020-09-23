import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kin_sdk_example/help/Constants.dart';

class CraeteInvoice extends StatefulWidget {
  @override
  _craeteInvoiceState createState() => _craeteInvoiceState();
}

class _craeteInvoiceState extends State<CraeteInvoice> {
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
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(labelText: amount),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: title),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: description),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(labelText: sku),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      lineItems,
                      style: TextStyle(
                          color: appDarkGreyColor,
                          fontFamily: 'medium',
                          fontSize: 18),
                    ),
                  ),
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
                    createInvoices,
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
