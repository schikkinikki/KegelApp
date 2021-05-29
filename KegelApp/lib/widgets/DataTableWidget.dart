import 'package:KegelApp/database/kegelAppDatabase.dart';
import 'package:KegelApp/models/session.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DataTableWidget extends StatefulWidget {
  @override
  _DataTableWidgetState createState() => _DataTableWidgetState();
}

class _DataTableWidgetState extends State<DataTableWidget> {
  @override
  Widget build(BuildContext context) {
    final sessionData = Provider.of<SessionProvider>(context);
    final List<DataRow> rowList = sessionData.dataRows;

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: 12,
          horizontalMargin: 10,
          columns: const <DataColumn>[
            DataColumn(
              label: Text(
                "Name",
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            DataColumn(
              label: Text(
                "Pumpe",
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            DataColumn(
              label: Text(
                "Klingeln",
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            DataColumn(
              label: Text(
                "Stina",
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            DataColumn(
              label: Text(
                "Durchwurf",
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            DataColumn(
              label: Text(
                "Handy",
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            DataColumn(
              label: Text(
                "Kugel bringen",
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            DataColumn(
              label: Text(
                "Zu zweit",
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            DataColumn(
              label: Text(
                "Lustwurf",
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ],
          rows: rowList,
        ),
      ),
    );
  }
}
