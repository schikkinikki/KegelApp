import 'package:KegelApp/database/kegelAppDatabase.dart';
import 'package:KegelApp/models/kegelbruder.dart';
import 'package:KegelApp/models/session.dart';

class SessionUtils {
  Future<List<Session>> returnLastSession() async {
    List<Session> allSessions = await DBProvider.db.getAllSessions();
    double comparator = double.parse(allSessions[0].date.replaceAll("-", ""));
    print(comparator);
    List<Session> sortedList = [];

    //sort list from newest to latest
    allSessions.forEach((session) {
      session.date = session.date.replaceAll("-", "");
      double dateDouble = double.parse(session.date);
      if (comparator - dateDouble < 0) {
        comparator = dateDouble;
      }
      print("ist in der gesamten Liste: " +
          session.date +
          " " +
          session.kegelbruder.name);
    });

    allSessions.forEach((session) {
      double dateDoubleZwei = double.parse(session.date);
      if (dateDoubleZwei - comparator == 0.0) {
        sortedList.add(session);
      }
    });

    print("Neuer Vergleich: " + comparator.toString());
    sortedList.forEach((element) {
      print(element.date + " " + element.kegelbruder.name);
    });

    return sortedList;
  }

  String returnPumpenkoenig(List<Session> sessionList) {
    String pumpenkoenig;
    sessionList.forEach((session) {
      if (session.kegelbruder.isPumpenKing == 1) {
        pumpenkoenig = session.kegelbruder.name;
      }
    });
    return pumpenkoenig;
  }

  String returnKegelkoenig(List<Session> sessionList) {
    String kegelkoenig;
    sessionList.forEach((session) {
      if (session.kegelbruder.isKing == 1) {
        kegelkoenig = session.kegelbruder.name;
      }
    });
    return kegelkoenig;
  }

  String returnMaxStrafen(List<Session> sessionList) {
    sessionList.sort((b, a) => a.kegelbruder
        .sumAll(a.kegelbruder)
        .compareTo(b.kegelbruder.sumAll(b.kegelbruder)));
    String maxStrafe = sessionList[0]
        .kegelbruder
        .sumAll(sessionList[0].kegelbruder)
        .toString();
    String name = sessionList[0].kegelbruder.name;
    String maxStrafeName = name + ": " + maxStrafe + " €";
    return maxStrafeName;
  }

  String returnMinPumpen(List<Session> sessionList) {
    sessionList
        .sort((a, b) => a.kegelbruder.pumpe.compareTo(b.kegelbruder.pumpe));
    String minPumpe = sessionList[0].kegelbruder.pumpe.toString();
    String name = sessionList[0].kegelbruder.name;
    String minPumpenName = name + ": " + minPumpe;
    return minPumpenName;
  }

  Future<List<Kegelbruder>> returnAnwesendeSpieler() async {
    List<Kegelbruder> kegelbruderListe =
        await DBProvider.db.getAllKegelbruder();
    List<Kegelbruder> anwesendeSpieler = [];

    kegelbruderListe.forEach((kegelbruder) {
      if (kegelbruder.anwesend == 1) {
        anwesendeSpieler.add(kegelbruder);
      }
    });

    return anwesendeSpieler;
  }
}
