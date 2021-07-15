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
    excelSheet.getRangeByName("N1").setText("Anwesend");
    excelSheet.getRangeByName("O1").setText("Abwesend");
    excelSheet.getRangeByName("P1").setText("Unabgemeldet");

    setPlayerstoExcel(excelSheet);
    setKingToExcel(excelSheet);
    setSumOfAll(excelSheet);
    setStrafenSchnitt(excelSheet);
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
      excelSheet
          .getRangeByName("N" + (count + 2).toString())
          .setNumber(player.anwesend.toDouble());
      excelSheet
          .getRangeByName("O" + (count + 2).toString())
          .setNumber(player.abwesend.toDouble());
      excelSheet
          .getRangeByName("P" + (count + 2).toString())
          .setNumber(player.unabgemeldet.toDouble());

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
        .getRangeByName("C" + (sessionList.length + 3).toString())
        .setText(getKing());
    excelSheet
        .getRangeByName("C" + (sessionList.length + 4).toString())
        .setText(getPumpenKing());
  }

  void setStrafenSchnitt(Worksheet excelSheet) {
    excelSheet
        .getRangeByName("A" + (sessionList.length + 6).toString())
        .setText("Strafenschnitt");
    excelSheet
        .getRangeByName("C" + (sessionList.length + 6).toString())
        .setNumber(getStrafenSchnitt());
  }

  double getStrafenSchnitt() {
    double schnitt = 0;
    double player = sessionList.length.toDouble();
    double sum = 0;

    sessionList.forEach((element) {
      sum += element.kegelbruder.sumAll(element.kegelbruder);
    });
    schnitt = (sum / player);
    return schnitt;
  }

  void setSumOfAll(Worksheet excelSheet) {
    excelSheet
        .getRangeByName("A" + (sessionList.length + 5).toString())
        .setText("Strafen gesamt");
    excelSheet
        .getRangeByName("C" + (sessionList.length + 5).toString())
        .setNumber(getSumOfAll());
  }

  double getSumOfAll() {
    double sumOfAll = 0;
    sessionList.forEach((session) {
      sumOfAll += session.kegelbruder.sumAll(session.kegelbruder);
    });
    return sumOfAll;
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
