import 'dart:math';

import 'package:e_billing/module/customer/model/ModelCustomerAll.dart';
import 'package:e_billing/module/login/model/ModelLogin.dart';
import 'package:e_billing/module/provider/ProviderPublic.dart';
import 'package:e_billing/module/widget/Function.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_fields/form_builder_fields.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class QuotationAdd extends StatefulWidget {
  final TCustomer customer;
  QuotationAdd({Key? key, required this.customer}) : super(key: key);

  @override
  _QuotationAddState createState() => _QuotationAddState();
}

class _QuotationAddState extends State<QuotationAdd> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    ModelLogin modelLogin = Provider.of<ProviderPublic>(context).modelLogin;
    return FormBuilder(
      key: _formKey,
      autovalidateMode: AutovalidateMode.always,
      child: Scaffold(
          appBar: AppBar(
            leading: BackButton(),
            title: Text("Add Quotation"),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                //company
                _buildCollapseGroup(
                  label: "Company",
                  children: [
                    _buildField(
                        icon: Icon(CupertinoIcons.building_2_fill),
                        nameKey: "company_name",
                        label: "Company Name",
                        initialValue: companyName),
                    _buildField(
                        icon: Icon(CupertinoIcons.number_square),
                        nameKey: "npwp",
                        label: "NPWP",
                        initialValue: companyNpwp),
                    _buildField(
                        icon: Icon(CupertinoIcons.placemark),
                        nameKey: "company_address",
                        label: "Address",
                        initialValue: CompanyAddress),
                  ],
                ),
                //Quotation
                _buildCollapseGroup(
                  label: "Quotation",
                  children: [
                    _buildField(
                        icon: Icon(CupertinoIcons.number_square),
                        nameKey: "number",
                        label: "Number",
                        initialValue: Random().nextInt(10000).toString()),
                    _buildField(
                        icon: Icon(CupertinoIcons.calendar),
                        nameKey: "date",
                        label: "Date",
                        isDatePicker: true),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "PIC USER",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    _buildField(
                        icon: Icon(CupertinoIcons.person),
                        nameKey: "pic_user",
                        label: "PIC User",
                        initialValue: modelLogin.data!.fullName!),
                    _buildField(
                        icon: Icon(CupertinoIcons.layers),
                        nameKey: "pic_position",
                        label: "PIC Position",
                        initialValue: modelLogin.data!.jabatan!),
                    _buildField(
                        icon: Icon(CupertinoIcons.phone),
                        nameKey: "pic_contact",
                        label: "PIC Contact",
                        initialValue: modelLogin.data!.telp!),
                    _buildField(
                        icon: Icon(CupertinoIcons.at),
                        nameKey: "pic_email",
                        label: "PIC Email",
                        initialValue: modelLogin.data!.email!),
                  ],
                ),
                //customer
                _buildCollapseGroup(label: "Customer", children: [
                  _buildField(
                      icon: Icon(CupertinoIcons.building_2_fill),
                      nameKey: "cus_company_name",
                      label: "Company name",
                      initialValue: widget.customer.nama!),
                  _buildField(
                      icon: Icon(CupertinoIcons.placemark),
                      nameKey: "cus_company_address",
                      label: "Company Address",
                      initialValue: widget.customer.alamat!),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "BILLING PIC",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  _buildField(
                      icon: Icon(CupertinoIcons.person),
                      nameKey: "cus_pic_user",
                      label: "Billing PIC User",
                      initialValue: widget.customer.pic!),
                  _buildField(
                      icon: Icon(CupertinoIcons.phone),
                      nameKey: "cus_pic_contact",
                      label: "Billing PIC Contact",
                      initialValue: widget.customer.telp!),
                  _buildField(
                      icon: Icon(CupertinoIcons.at),
                      nameKey: "cus_pic_email",
                      label: "Billing PIC Email",
                      initialValue: widget.customer.email!),
                ])
              ],
            ),
          )),
    );
  }

  Widget _buildCollapseGroup(
      {required String label, required List<Widget> children}) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ExpandablePanel(
            header: Text(
              label,
              style: TextStyle(fontSize: 20),
            ),
            theme: ExpandableThemeData(
              headerAlignment: ExpandablePanelHeaderAlignment.center,
            ),
            expanded: Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: children),
            ),
            collapsed: Container()),
      ),
    );
  }

  Widget _buildField(
      {required Icon icon,
      required String nameKey,
      String label = "Input Text",
      String initialValue = "",
      bool isDatePicker = false}) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 10),
            child: icon,
          ),
          Expanded(
            child: isDatePicker
                ? FormBuilderDateTimePicker(
                    name: nameKey,
                    format: DateFormat("dd/MM/y"),
                    inputType: InputType.date,
                    decoration: InputDecoration(
                      labelText: label,
                    ),
                    initialValue: DateTime.now(),
                    enabled: true,
                  )
                : FormBuilderTextField(
                    name: nameKey,
                    initialValue: initialValue,
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(), labelText: label),
                  ),
          ),
        ],
      ),
    );
  }
}
