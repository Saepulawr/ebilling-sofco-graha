import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CardCustomerList extends StatefulWidget {
  final String name;
  final String address;
  final String pic;
  final String email;
  final String telp;
  CardCustomerList(
      {Key? key,
      this.name = "",
      this.address = "",
      this.pic = "",
      this.email = "",
      this.telp = ""})
      : super(key: key);

  @override
  _CardCustomerListState createState() => _CardCustomerListState();
}

class _CardCustomerListState extends State<CardCustomerList> {
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
                  label: widget.pic,
                ),
                itemIcon(
                  icon: Icon(
                    Icons.email,
                    color: Colors.grey,
                  ),
                  label: widget.email,
                ),
                itemIcon(
                  icon: Icon(
                    Icons.phone,
                    color: Colors.grey,
                  ),
                  label: widget.telp,
                ),
              ],
            ),
          ),
          collapsed: Container(),
          header: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.indigoAccent,
                child: Text(widget.name[0]),
                foregroundColor: Colors.white,
              ),
              title: itemIcon(
                  label: widget.name,
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: itemIcon(label: widget.address)),
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
