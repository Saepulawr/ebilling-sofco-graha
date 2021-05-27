import 'package:e_billing/module/customer/model/ModelCustomerAll.dart';
import 'package:e_billing/module/quotation/Quotation.dart';
import 'package:e_billing/module/quotation/model/ModelQuotationAll.dart';
import 'package:e_billing/module/widget/Api.dart';
import 'package:e_billing/module/widget/Function.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CardQuotationList extends StatefulWidget {
  final TQuotation quotation;
  CardQuotationList({Key? key, required this.quotation}) : super(key: key);

  @override
  _CardQuotationListState createState() => _CardQuotationListState();
}

class _CardQuotationListState extends State<CardQuotationList> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
        child: ExpandablePanel(
          theme: ExpandableThemeData(
              headerAlignment: ExpandablePanelHeaderAlignment.center),
          collapsed: Container(),
          expanded: Container(
            // height: 30,
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Text("Password : "),
                Text(getPasswordFromHash(widget.quotation.hashid!)),
                Spacer(),
                ElevatedButton.icon(
                    onPressed: () {
                      launchURL(urlViewInvoice(widget.quotation.hashid!));
                    },
                    icon: Icon(Icons.remove_red_eye),
                    label: Text("View"))
              ],
            ),
          ),
          header: ListTile(
              leading: Icon(
                widget.quotation.sign != null
                    ? Icons.assignment_turned_in
                    : Icons.assignment,
                color:
                    widget.quotation.sign != null ? Colors.green : Colors.blue,
              ),
              title: itemIcon(
                  label: widget.quotation.idCustomer!.nama!,
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: itemIcon(
                  label:
                      "${widget.quotation.tanggal} - ${widget.quotation.nomor}")),
        ),
        secondaryActions: <Widget>[
          IconSlideAction(
            caption: 'Edit',
            color: Colors.amber,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            onTap: () {},
          ),
          IconSlideAction(
            caption: 'Delete',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget itemIcon({Icon? icon, required String label, TextStyle? style}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          icon != null ? icon : Container(),
          icon != null
              ? SizedBox(
                  width: 10,
                )
              : Container(),
          Expanded(
              child: Text(
            label,
            style: style,
          )),
        ],
      ),
    );
  }
}
