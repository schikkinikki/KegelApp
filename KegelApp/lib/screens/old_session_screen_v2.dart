import 'package:KegelApp/database/kegelAppDatabase.dart';
import 'package:KegelApp/models/kegelabend_excel_sheet.dart';
import 'package:KegelApp/models/session.dart';
import 'package:KegelApp/screens/old_session_detail_screen.dart';
import 'package:flutter/material.dart';

class OldSessionScreenV2 extends StatefulWidget {
  @override
  _OldSessionScreenV2State createState() => _OldSessionScreenV2State();
  static const routeName = "/old-session-screen";
}

class _OldSessionScreenV2State extends State<OldSessionScreenV2> {
  bool isExpanded = false;

  //add rows to a list of DataRows to pass them to the DatatableWidget
  List<DataRow> addRow(List<Session> sessionList) {
    List<DataRow> dataRows = [];

    sessionList.forEach((session) {
      dataRows.add(
        DataRow(cells: <DataCell>[
          DataCell(Text(session.kegelbruder.name)),
          DataCell(Text(
            session.kegelbruder.pumpe.toString(),
            textAlign: TextAlign.center,
          )),
          DataCell(Text(
            session.kegelbruder.klingeln.toString(),
            textAlign: TextAlign.center,
          )),
          DataCell(Text(
            session.kegelbruder.stina.toString(),
            textAlign: TextAlign.center,
          )),
          DataCell(Text(
            session.kegelbruder.durchwurf.toString(),
            textAlign: TextAlign.center,
          )),
          DataCell(Text(
            session.kegelbruder.handy.toString(),
            textAlign: TextAlign.center,
          )),
          DataCell(Text(
            session.kegelbruder.kugelBringen.toString(),
            textAlign: TextAlign.center,
          )),
          DataCell(Text(
            session.kegelbruder.zweiPersonenAufDerBahn.toString(),
            textAlign: TextAlign.center,
          )),
          DataCell(Text(
            session.kegelbruder.lustwurf.toString(),
            textAlign: TextAlign.center,
          )),
        ]),
      );
    });

    return dataRows;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(48, 48, 48, 1),
        title: Text(
          "Alte Kegelabende",
          style:
              TextStyle(fontSize: 30, color: Color.fromRGBO(217, 226, 236, 1)),
        ),
        centerTitle: true,
      ),
      backgroundColor: Color.fromRGBO(48, 48, 48, 1),
      body: FutureBuilder(
        future: DBProvider.db.getAllSessions(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text("Noch keine Kegelabende gespielt!"),
            );
          }
          if (snapshot.hasData) {
            List<Session> datalist = snapshot.data;
            var dataMap = datalist.fold<Map<String, List<Session>>>(
                {},
                (map, element) => map
                  ..update(element.date, (list) => list..add(element),
                      ifAbsent: () => [element]));
            return ListView.builder(
              itemBuilder: (context, index) {
                return !isExpanded
                    ? Container(
                        margin: EdgeInsets.all(15),
                        height: isExpanded ? 100 : 50,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(15),
                            color: Color.fromRGBO(16, 42, 67, 0.7)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              dataMap.keys.elementAt(index),
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromRGBO(217, 226, 236, 1)),
                            ),
                            IconButton(
                                icon: Icon(
                                  Icons.arrow_downward_rounded,
                                  color: Color.fromRGBO(217, 226, 236, 1),
                                  size: 28,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isExpanded = !isExpanded;
                                  });
                                }),
                          ],
                        ),
                      )
                    : Container(
                        margin: EdgeInsets.all(15),
                        height: isExpanded ? 100 : 50,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(15),
                            color: Color.fromRGBO(16, 42, 67, 0.7)),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  dataMap.keys.elementAt(index),
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Color.fromRGBO(217, 226, 236, 1)),
                                ),
                                IconButton(
                                    icon: Icon(
                                      Icons.arrow_upward_rounded,
                                      color: Color.fromRGBO(217, 226, 236, 1),
                                      size: 28,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        isExpanded = !isExpanded;
                                      });
                                    }),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                RaisedButton(
                                  child: Text(
                                    "Teilen",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  onPressed: () {
                                    String sessionkey =
                                        dataMap.keys.elementAt(index);
                                    List<Session> selectedSessionList =
                                        dataMap[sessionkey];
                                    ExcelCreator excelCreator =
                                        new ExcelCreator(selectedSessionList);
                                    excelCreator.createExcel();
                                  },
                                ),
                                RaisedButton(
                                  child: Text(
                                    "Details",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  onPressed: () {
                                    String sessionkey =
                                        dataMap.keys.elementAt(index);
                                    List<Session> selectedSessionList =
                                        dataMap[sessionkey];
                                    List<DataRow> rowList =
                                        addRow(selectedSessionList);
                                    Navigator.of(context).pushNamed(
                                        OldSessionDetailScreen.routeName,
                                        arguments: rowList);
                                  },
                                )
                              ],
                            )
                          ],
                        ),
                      );
              },
              itemCount: dataMap.length,
            );
          }
        },
      ),
    );
  }
}
