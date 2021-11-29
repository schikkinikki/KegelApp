import 'package:KegelApp/database/kegelAppDatabase.dart';
import 'package:KegelApp/models/session.dart';

class SessionUtils {
  Future<List<Session>> returnLastSession() async {
    List<Session> allSessions = await DBProvider.db.getAllSessions();

    //sort list from newest to latest
    allSessions.sort((b, a) => a.date.compareTo(b.date));
    List<Session> latestSession = [];

    //add all session data that matches the newest date to new list and return it
    allSessions.forEach((session) {
      if (session.date.contains(allSessions[0].date)) {
        latestSession.add(session);
      }
    });

    return latestSession;
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
}
