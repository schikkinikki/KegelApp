import 'package:KegelApp/models/kegelbruder.dart';
import 'package:KegelApp/models/session.dart';
import 'package:open_file/open_file.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_mailer/flutter_mailer.dart';

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
    //sendEmail(excelFileName);
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
    excelSheet.getRangeByName("J1").setText("Kugel zum Klo");
    excelSheet.getRangeByName("K1").setText("Kugel fallenlasse");
    excelSheet.getRangeByName("L1").setText("Alle Neune");
    excelSheet.getRangeByName("M1").setText("Strafen gesamt");

    setPlayerstoExcel(excelSheet);
    setKingToExcel(excelSheet);
  }

  //fill sheet with data from saved session
  void setPlayerstoExcel(Worksheet excelSheet) {
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
      excelSheet
          .getRangeByName("J" + (count + 2).toString())
          .setNumber(player.kugelKlo.toDouble());
      excelSheet
          .getRangeByName("K" + (count + 2).toString())
          .setNumber(player.kugelFallenLassen.toDouble());
      excelSheet
          .getRangeByName("L" + (count + 2).toString())
          .setNumber(player.alleNeune.toDouble());
      excelSheet
          .getRangeByName("M" + (count + 2).toString())
          .setNumber(player.sumAll(player));

      count += 1;
    }
  }

  void setKingToExcel(Worksheet excelSheet) {
    excelSheet
        .getRangeByName("A" + (sessionList.length + 3).toString())
        .setText("Kegelkönig:");
    excelSheet
        .getRangeByName("A" + (sessionList.length + 4).toString())
        .setText("Pumpenkönig:");

    excelSheet
        .getRangeByName("B" + (sessionList.length + 3).toString())
        .setText(getKing());
    excelSheet
        .getRangeByName("B" + (sessionList.length + 4).toString())
        .setText(getPumpenKing());
  }

  String getKing() {
    String king = "";
    sessionList.forEach((session) {
      if (session.kegelbruder.isKing == 1) {
        king = session.kegelbruder.name;
      }
    });
    return king;
  }

  String getPumpenKing() {
    String pumpenKing = "";
    sessionList.forEach((session) {
      if (session.kegelbruder.isPumpenKing == 1) {
        pumpenKing = session.kegelbruder.name;
      }
    });
    return pumpenKing;
  }

  void sendEmail(String filePath) async {
    MailOptions mailOptions =
        MailOptions(attachments: [filePath], isHTML: true);
    try {
      await FlutterMailer.send(mailOptions);
    } catch (error) {
      //
    }
  }
}
