import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CardQuotationList extends StatefulWidget {
  CardQuotationList({Key? key}) : super(key: key);

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
        child: ListTile(
            leading: Icon(
              Icons.assignment,
            ),
            onTap: () {},
            title: itemIcon(
                label: "nama Pt",
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: itemIcon(label: "01/01/2021 - LCI0002348/x8uhh/3448")),
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
