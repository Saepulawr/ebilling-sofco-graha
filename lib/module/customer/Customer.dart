import 'package:e_billing/module/customer/widget/CardCustomerList.dart';
import 'package:e_billing/module/widget/Function.dart';
import 'package:flutter/material.dart';

class Customer extends StatefulWidget {
  Customer({Key? key}) : super(key: key);

  @override
  _CustomerState createState() => _CustomerState();
}

class _CustomerState extends State<Customer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                zoomDrawerController.toggle!();
              }),
          title: Text("Customer"),
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return CardCustomerList();
          },
        ));
  }
}
