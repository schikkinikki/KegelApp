import 'package:KegelApp/widgets/DataTableWidget.dart';
import 'package:flutter/material.dart';

class OldSessionScreen extends StatefulWidget {
  static const routeName = "/old-session-screen";

  @override
  _OldSessionScreenState createState() => _OldSessionScreenState();
}

// stores ExpansionPanel state information
class Item {
  Item({
    @required this.expandedValue,
    @required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

class _OldSessionScreenState extends State<OldSessionScreen> {
  List<Item> itemsDummyList = [
    Item(expandedValue: "Hi", headerValue: "Tabelle 1"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.orange, Colors.red],
            ),
          ),
        ),
        title: Text(
          "Kegel App",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Colors.black54,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: ExpansionPanelList(
            expansionCallback: (panelIndex, isExpanded) {
              setState(() {
                itemsDummyList[panelIndex].isExpanded = !isExpanded;
              });
            },
            children: itemsDummyList.map((Item item) {
              return ExpansionPanel(
                headerBuilder: (context, isExpanded) {
                  return ListTile(
                    title: Text(item.headerValue),
                  );
                },
                body: DataTableWidget(),
                isExpanded: item.isExpanded,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
