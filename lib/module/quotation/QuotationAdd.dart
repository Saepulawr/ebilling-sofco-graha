import 'package:flutter/material.dart';

class QuotationAdd extends StatefulWidget {
  QuotationAdd({Key? key}) : super(key: key);

  @override
  _QuotationAddState createState() => _QuotationAddState();
}

class _QuotationAddState extends State<QuotationAdd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text("Add Quotation"),
      ),
    );
  }
}
