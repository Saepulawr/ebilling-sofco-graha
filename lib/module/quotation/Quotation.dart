import 'dart:convert';
import 'package:e_billing/module/customer/model/ModelCustomerAll.dart';
import 'package:e_billing/module/provider/ProviderPublic.dart';
import 'package:e_billing/module/quotation/QuotationAdd.dart';
import 'package:e_billing/module/quotation/widget/CardQuotationList.dart';
import 'package:e_billing/module/widget/Api.dart';
import 'package:e_billing/module/widget/Function.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:select_dialog/select_dialog.dart';
import 'package:provider/provider.dart';

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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(Icons.search),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(Icons.more_horiz),
          )
        ],
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        onPressed: () async {
          List<TCustomer> customers = [];
          if (Provider.of<ProviderPublic>(context, listen: false)
                  .modelCustomerAll
                  .total ==
              null) {
            await API().getData(
              url: UrlApi().customer,
              onComplete: (data, statusCode) {
                if (statusCode == 200) {
                  try {
                    Provider.of<ProviderPublic>(context, listen: false)
                        .setModelCustomerAll(
                            ModelCustomerAll.fromJson(jsonDecode(data)));
                    customers.clear();
                    customers = ModelCustomerAll.fromJson(jsonDecode(data))
                        .data!
                        .tCustomer!;
                  } catch (e) {}
                }
              },
            );
          } else {
            customers = Provider.of<ProviderPublic>(context, listen: false)
                .modelCustomerAll
                .data!
                .tCustomer!;
          }
          late TCustomer customerSelected;
          await SelectDialog.showModal<TCustomer>(
            context,
            label: "Quotation for ?",
            selectedValue: TCustomer(),
            items: customers,
            itemBuilder: (context, item, isSelected) {
              return Column(children: [
                ListTile(
                  title: Text(item.nama!),
                  subtitle: Text(
                    item.alamat!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Divider()
              ]);
            },
            onFind: (text) {
              List<TCustomer> cus = [];
              customers.forEach((element) {
                if (element.nama!.toLowerCase().contains(text.toLowerCase()) ||
                    element.alamat!.toLowerCase().contains(text.toLowerCase()))
                  cus.add(element);
              });
              return Future.value(cus);
            },
            onChange: (TCustomer selected) {
              setState(() {
                customerSelected = selected;
              });
            },
          );
          if (customerSelected != null) {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => QuotationAdd(
                customer: customerSelected,
              ),
            ));
          }
        },
      ),
    );
  }
}
