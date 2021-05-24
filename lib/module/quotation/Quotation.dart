import 'package:e_billing/module/quotation/CardQuotationList.dart';
import 'package:e_billing/module/widget/Function.dart';
import 'package:flutter/material.dart';

class Quotation extends StatefulWidget {
  Quotation({Key? key}) : super(key: key);

  @override
  _QuotationState createState() => _QuotationState();
}

class _QuotationState extends State<Quotation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              zoomDrawerController.toggle!();
            }),
        title: Text("Quotation"),
      ),
      body: Container(
        // color: Colors.amber,
        child: ListView.builder(
          itemBuilder: (context, index) {
            return CardQuotationList();
          },
          itemCount: 20,
        ),
      ),
    );
  }
}
