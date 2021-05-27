import 'dart:convert';
import 'package:after_layout/after_layout.dart';
import 'package:e_billing/module/customer/model/ModelCustomerAll.dart';
import 'package:e_billing/module/provider/ProviderPublic.dart';
import 'package:e_billing/module/quotation/QuotationAdd.dart';
import 'package:e_billing/module/quotation/model/ModelQuotationAll.dart';
import 'package:e_billing/module/quotation/widget/CardQuotationList.dart';
import 'package:e_billing/module/widget/Api.dart';
import 'package:e_billing/module/widget/Function.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:select_dialog/select_dialog.dart';
import 'package:provider/provider.dart';

class Quotation extends StatefulWidget {
  Quotation({Key? key}) : super(key: key);

  @override
  _QuotationState createState() => _QuotationState();
}

class _QuotationState extends State<Quotation>
    with AfterLayoutMixin<Quotation> {
  GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey = GlobalKey();
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
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
      body: _buildBody(),
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
            String result = await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => QuotationAdd(
                customer: customerSelected,
              ),
            ));
            try {
              if (result == "ok") {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Success"),
                  backgroundColor: Colors.green,
                ));
                _handleRefresh();
              }
            } catch (e) {}
          }
        },
      ),
    );
  }

  Future<void> _handleRefresh() async {
    setState(() {
      isLoading = true;
    });
    Provider.of<ProviderPublic>(context, listen: false)
        .setModelQuotationAll(ModelQuotationAll());
    await API().getData(
      url: UrlApi().quotationGetAll,
      onComplete: (data, statusCode) {
        if (statusCode == 200) {
          try {
            Provider.of<ProviderPublic>(context, listen: false)
                .setModelQuotationAll(
                    ModelQuotationAll.fromJson(jsonDecode(data)));
          } catch (e) {}
        }
      },
    );
    setState(() {
      isLoading = false;
    });
  }

  Widget _buildBody() {
    ModelQuotationAll modelQuotationAll =
        Provider.of<ProviderPublic>(context).modelQuotationAll;
    Widget list = Center(
        child: SpinKitCubeGrid(
      color: Theme.of(context).primaryColor,
    ));
    if (!isLoading) {
      if (modelQuotationAll.total != null) {
        list = ListView.builder(
          itemBuilder: (context, index) {
            // print(modelQuotationAll.data!.tQuotation![index].toJson());
            return CardQuotationList(
              quotation: modelQuotationAll.data!.tQuotation![index],
            );
          },
          itemCount: modelQuotationAll.total,
        );
      } else {
        list = SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height,
            child: Text("Failed Connect To Server!"),
          ),
        );
      }
    }
    return LiquidPullToRefresh(
        key: _refreshIndicatorKey,
        color: Theme.of(context).primaryColor,
        onRefresh: _handleRefresh,
        child: list);
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _handleRefresh();
  }
}
