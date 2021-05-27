import 'dart:convert';

import 'package:e_billing/module/customer/model/ModelCustomerAll.dart';
import 'package:e_billing/module/customer/widget/CardCustomerList.dart';
import 'package:e_billing/module/provider/ProviderPublic.dart';
import 'package:e_billing/module/widget/Api.dart';
import 'package:e_billing/module/widget/Function.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:after_layout/after_layout.dart';

class Customer extends StatefulWidget {
  Customer({Key? key}) : super(key: key);

  @override
  _CustomerState createState() => _CustomerState();
}

class _CustomerState extends State<Customer> with AfterLayoutMixin<Customer> {
  GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey = GlobalKey();
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
  }

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
        title: Text("Customer"),
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
    );
  }

  Future<void> _handleRefresh() async {
    setState(() {
      isLoading = true;
    });
    Provider.of<ProviderPublic>(context, listen: false)
        .setModelCustomerAll(ModelCustomerAll());
    await API().getData(
      url: UrlApi().customer,
      onComplete: (data, statusCode) {
        if (statusCode == 200) {
          try {
            Provider.of<ProviderPublic>(context, listen: false)
                .setModelCustomerAll(
                    ModelCustomerAll.fromJson(jsonDecode(data)));
          } catch (e) {}
        }
      },
    );
    setState(() {
      isLoading = false;
    });
  }

  Widget _buildBody() {
    ModelCustomerAll modelCustomerAll =
        Provider.of<ProviderPublic>(context).modelCustomerAll;
    Widget list = Center(
        child: SpinKitCubeGrid(
      color: Theme.of(context).primaryColor,
    ));
    if (!isLoading) {
      if (modelCustomerAll.total != null) {
        list = ListView.builder(
          itemBuilder: (context, index) {
            return CardCustomerList(
              name: modelCustomerAll.data!.tCustomer![index].nama!,
              address: modelCustomerAll.data!.tCustomer![index].alamat!,
              pic: modelCustomerAll.data!.tCustomer![index].pic!,
              email: modelCustomerAll.data!.tCustomer![index].email!,
              telp: modelCustomerAll.data!.tCustomer![index].telp!,
            );
          },
          itemCount: modelCustomerAll.total,
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
