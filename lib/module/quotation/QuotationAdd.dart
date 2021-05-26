import 'dart:math';

import 'package:e_billing/module/customer/model/ModelCustomerAll.dart';
import 'package:e_billing/module/login/model/ModelLogin.dart';
import 'package:e_billing/module/provider/ProviderPublic.dart';
import 'package:e_billing/module/widget/Function.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class QuotationAdd extends StatefulWidget {
  final TCustomer customer;
  QuotationAdd({Key? key, required this.customer}) : super(key: key);

  @override
  _QuotationAddState createState() => _QuotationAddState();
}

class _QuotationAddState extends State<QuotationAdd> {
  final _formKey = GlobalKey<FormBuilderState>();
  final formatCurrency = new NumberFormat.simpleCurrency(locale: 'id_ID');
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  int _hargaPaketEmployee = 0;
  int _hargaperEmployee = 0;
  int _hargaSetelahDiskonEmployes = 0;
  @override
  Widget build(BuildContext context) {
    ModelLogin modelLogin = Provider.of<ProviderPublic>(context).modelLogin;
    Size _screen = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: BackButton(),
        title: Text("Add Quotation"),
      ),
      body: SingleChildScrollView(
        child: FormBuilder(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            children: [
              FormBuilderTextField(
                name: "ee",
              ),
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
              ]),
              //detail
              _buildCollapseGroup(label: "Detail", children: [
                _buildField(
                    icon: Icon(CupertinoIcons.person_3_fill),
                    nameKey: "detail_total_employes",
                    label: "Total Employees",
                    textInputType: TextInputType.number,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          int.tryParse(value)! <= 0) {
                        return "Please input > 0";
                      }
                    },
                    onChange: (val) {
                      _hitung();
                    }),
                _buildField(
                    icon: Icon(CupertinoIcons.percent),
                    nameKey: "detail_dicount_employes",
                    label: "Discount",
                    textInputType: TextInputType.number,
                    onChange: (value) {
                      _hitung();
                    },
                    validator: (value) {
                      try {
                        if (int.tryParse(value!)! > 100) return "Input Error!";
                      } catch (e) {}
                    }),
                _buildField(
                  icon: Icon(CupertinoIcons.list_bullet),
                  nameKey: "detail_desc_employes",
                  label: "Description",
                ),
              ]),

              //total
              Container(
                alignment: Alignment.centerRight,
                // height: 300,
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Price Total",
                          style: TextStyle(fontSize: 20),
                        ),
                        Container(
                          // width: _screen.width * 0.5,
                          padding: EdgeInsets.only(left: 20),
                          alignment: Alignment.centerRight,
                          child: Text(
                            formatCurrency.format(_hargaPaketEmployee),
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Price/employee",
                          style: TextStyle(fontSize: 20),
                        ),
                        Container(
                          // width: _screen.width * 0.5,
                          padding: EdgeInsets.only(left: 20),
                          alignment: Alignment.centerRight,
                          child: Text(
                            formatCurrency.format(_hargaperEmployee),
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Price After Discount",
                          style: TextStyle(fontSize: 20),
                        ),
                        Container(
                          // width: _screen.width * 0.5,
                          padding: EdgeInsets.only(left: 20),
                          alignment: Alignment.centerRight,
                          child: Text(
                            formatCurrency.format(_hargaSetelahDiskonEmployes),
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: RoundedLoadingButton(
        borderRadius: 0,
        // elevation: 0,
        animateOnTap: false,
        height: 80,
        width: _screen.width,
        color: Theme.of(context).primaryColor,

        child: Text('Generate',
            style: TextStyle(color: Colors.white, fontSize: 20)),
        controller: _btnController,
        onPressed: () {
          Future.delayed(Duration(seconds: 3), () => _btnController.success());
        },
      ),
    );
  }

  void _hitung() {
    if (_formKey.currentState!.saveAndValidate()) {
      Map<int, int> paketHargaEmployee = {
        //hargapaket 500000 jika kurang dari 26 karyawan
        // 25: 500000,
        //jumlah employee : harga/karyawan
        49: 20000,
        199: 18000,
        349: 15000,
        499: 8500,
        999: 7000,
        // 10000: 5500,
      };
      int diskon = int.tryParse(_formKey
              .currentState!.value['detail_dicount_employes']
              .toString()) ??
          0;
      int totalEmployee = int.tryParse(_formKey
              .currentState!.value['detail_total_employes']
              .toString()) ??
          0;
      setState(() {
        if (totalEmployee <= 25) {
          _hargaPaketEmployee = 500000;
          _hargaperEmployee = _hargaPaketEmployee ~/ totalEmployee;
          _hargaSetelahDiskonEmployes =
              (_hargaPaketEmployee - (_hargaPaketEmployee * (diskon / 100)))
                  .toInt();
        } else if (totalEmployee > 999) {
          _hargaperEmployee = 5500;
          _hargaPaketEmployee = _hargaperEmployee * totalEmployee;
          _hargaSetelahDiskonEmployes =
              (_hargaPaketEmployee - (_hargaPaketEmployee * (diskon / 100)))
                  .toInt();
        } else {
          for (int a in paketHargaEmployee.keys) {
            if (totalEmployee <= a) {
              _hargaperEmployee = paketHargaEmployee[a]!;
              _hargaPaketEmployee = _hargaperEmployee * totalEmployee;
              _hargaSetelahDiskonEmployes =
                  (_hargaPaketEmployee - (_hargaPaketEmployee * (diskon / 100)))
                      .toInt();
              return;
            }
          }
        }
      });
    } else {
      setState(() {
        _hargaperEmployee = 0;
        _hargaPaketEmployee = 0;
        _hargaSetelahDiskonEmployes = 0;
      });
    }
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
      bool isDatePicker = false,
      String? Function(String?)? validator,
      void Function(String?)? onChange,
      TextInputType textInputType = TextInputType.text}) {
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
                    keyboardType: textInputType,
                    initialValue: initialValue,
                    validator: validator,
                    onChanged: onChange,
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(), labelText: label),
                  ),
          ),
        ],
      ),
    );
  }
}
