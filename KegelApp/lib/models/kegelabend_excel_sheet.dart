import 'package:KegelApp/models/kegelbruder.dart';
import 'package:KegelApp/models/session.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

class ExcelCreator {
  List<Session> sessionList = [];

  ExcelCreator(this.sessionList);

  //create the excel sheet and set up path in phone enviorement
  Future<void> createExcel() async {
    final Workbook workbook = Workbook();
    createSheet(workbook);
    final List<int> excelBytes = workbook.saveAsStream();
    workbook.dispose();

    final String excelPath = (await getApplicationDocumentsDirectory()).path;
    final String excelFileName = "$excelPath/Kegelabend.xlsx";
    final File excelFile = File(excelFileName);
    await excelFile.writeAsBytes(excelBytes, flush: true);
    OpenFile.open(excelFileName);
  }

  //create basic headers for the sheet
  void createSheet(Workbook workbook) async {
    final Worksheet excelSheet = workbook.worksheets[0];
    excelSheet.getRangeByName("A1").setText("Name");
    excelSheet.getRangeByName("B1").setText("Pumpe");
    excelSheet.getRangeByName("C1").setText("Klingeln");
    excelSheet.getRangeByName("D1").setText("Stina");
    excelSheet.getRangeByName("E1").setText("Durchwurf");
    excelSheet.getRangeByName("F1").setText("Handy");
    excelSheet.getRangeByName("G1").setText("Kugel bringen");
    excelSheet.getRangeByName("H1").setText("2. auf der Bahn");
    excelSheet.getRangeByName("I1").setText("Lustwurf");

    //fill sheet with data from saved session
    int count = 0;
    while (count != sessionList.length) {
      Kegelbruder player = sessionList.elementAt(count).kegelbruder;
      excelSheet
          .getRangeByName("A" + (count + 2).toString())
          .setText(player.name);
      excelSheet
          .getRangeByName("B" + (count + 2).toString())
          .setNumber(player.pumpe.toDouble());
      excelSheet
          .getRangeByName("C" + (count + 2).toString())
          .setNumber(player.klingeln.toDouble());
      excelSheet
          .getRangeByName("D" + (count + 2).toString())
          .setNumber(player.stina.toDouble());
      excelSheet
          .getRangeByName("E" + (count + 2).toString())
          .setNumber(player.durchwurf.toDouble());
      excelSheet
          .getRangeByName("F" + (count + 2).toString())
          .setNumber(player.handy.toDouble());
      excelSheet
          .getRangeByName("G" + (count + 2).toString())
          .setNumber(player.kugelBringen.toDouble());
      excelSheet
          .getRangeByName("H" + (count + 2).toString())
          .setNumber(player.zweiPersonenAufDerBahn.toDouble());
      excelSheet
          .getRangeByName("I" + (count + 2).toString())
          .setNumber(player.lustwurf.toDouble());

      count += 1;
    }
  }
}
