import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kin_sdk_example/help/Constants.dart';
import 'package:kin_sdk_example/ui/create_invoice.dart';

class Invoice extends StatefulWidget {
  @override
  _invoiceState createState() => _invoiceState();
}

class _invoiceState extends State<Invoice> {
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
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CraeteInvoice()),
                      );
                    },
                    child: Text(
                      createInvoices,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'medium',
                        color: appBlueColor,
                      ),
                    ),
                  ),
                ],
              ),
            ]),
      ),
    );
  }
}
