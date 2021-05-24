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
        child: ExpandablePanel(
          theme: ExpandableThemeData(
              headerAlignment: ExpandablePanelHeaderAlignment.center),
          expanded: Container(
            padding: EdgeInsets.only(left: 70),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                itemIcon(
                  icon: Icon(
                    Icons.person,
                    color: Colors.grey,
                  ),
                  label: "Pak Joko Surahman",
                ),
                itemIcon(
                  icon: Icon(
                    Icons.email,
                    color: Colors.grey,
                  ),
                  label: "joko@angindamai.com",
                ),
                itemIcon(
                  icon: Icon(
                    Icons.phone,
                    color: Colors.grey,
                  ),
                  label: "+62891111887887",
                ),
              ],
            ),
          ),
          collapsed: Container(),
          header: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.indigoAccent,
              child: Text('T'),
              foregroundColor: Colors.white,
            ),
            title: itemIcon(
                label: "PT Angin Damai",
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: itemIcon(label: "21/02/2021"),
          ),
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
