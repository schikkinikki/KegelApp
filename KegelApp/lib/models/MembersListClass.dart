import 'package:KegelApp/database/kegelAppDatabase.dart';
import 'package:KegelApp/widgets/DynamicBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'kegelbruder.dart';
import 'package:flutter/foundation.dart';

class MemberListClass extends ChangeNotifier {
  List<Kegelbruder> memberlist = [];

  List<Kegelbruder> get member {
    return [...memberlist];
  }

  void addMember(Kegelbruder member) {
    memberlist.add(member);
    notifyListeners();
  }

  void deleteMember(Kegelbruder member) {
    memberlist.removeWhere((element) => element.name == member.name);
    notifyListeners();
  }

  List<String> getPlayerNames() {
    List<String> playerNames = [];
    memberlist.forEach((player) {
      playerNames.add(player.name);
    });
    return playerNames;
  }

  Kegelbruder getOnePlayer(String name) {
    return memberlist.firstWhere((element) => element.name == name);
  }

  //reset all entrys for Kegelbruder
  void resetStrafen(Kegelbruder member) {
    member.pumpe = 0;
    member.klingeln = 0;
    member.stina = 0;
    member.handy = 0;
    member.kugelBringen = 0;
    member.lustwurf = 0;
    member.durchwurf = 0;
    member.zweiPersonenAufDerBahn = 0;
    member.kugelKlo = 0;
    member.kugelFallenLassen = 0;
    member.alleNeune = 0;
    member.isSelected = 0;
    member.anwesend = 0;
    member.abwesend = 0;
    member.unabgemeldet = 0;
  }

  // set Strafen for selected Player higher
  void setStrafen(int index, String strafen) async {
    // get all Kegelbruder from DB
    List<Kegelbruder> kegelbruderListe =
        await DBProvider.db.getAllKegelbruder();

    // get strafenliste from kegelbruder an loop through until he is no longer selected
    kegelbruderListe.forEach((kegelbruder) async {
      while (kegelbruder.isSelected == 1) {
        switch (strafen) {
          case "Pumpe":
            kegelbruder.setPumpe(1);
            await DBProvider.db.updateKegelbruder(kegelbruder);
            print("pumpe" + kegelbruder.pumpe.toString());
            break;
          case "Klingeln":
            kegelbruder.setKlingeln(1);
            await DBProvider.db.updateKegelbruder(kegelbruder);
            print("klingeln" + kegelbruder.klingeln.toString());
            break;
          case "3 mittig":
            kegelbruder.setMittenDurch(1);
            await DBProvider.db.updateKegelbruder(kegelbruder);
            print("stina" + kegelbruder.stina.toString());
            break;
          case "Durchwurf":
            kegelbruder.setDurchWurf(1);
            await DBProvider.db.updateKegelbruder(kegelbruder);
            print("durchwurf" + kegelbruder.durchwurf.toString());
            break;
          case "Handy":
            kegelbruder.setHandy(1);
            await DBProvider.db.updateKegelbruder(kegelbruder);
            print("handy" + kegelbruder.handy.toString());
            break;
          case "Kugel bringen":
            kegelbruder.setKugelBringen(1);
            await DBProvider.db.updateKegelbruder(kegelbruder);
            print("kugel bringen" + kegelbruder.kugelBringen.toString());
            break;
          case "Zu 2. auf der Bahn":
            kegelbruder.setZuZweitaufDerBahn(1);
            await DBProvider.db.updateKegelbruder(kegelbruder);
            print("zu 2." + kegelbruder.zweiPersonenAufDerBahn.toString());
            break;
          case "Lustwurf":
            kegelbruder.setLustwurf(1);
            await DBProvider.db.updateKegelbruder(kegelbruder);
            print("lustwurf" + kegelbruder.lustwurf.toString());
            break;
          case "Kugel zum Klo":
            kegelbruder.setKugelZumKli(1);
            await DBProvider.db.updateKegelbruder(kegelbruder);
            break;
          case "Kugel fallenlassen":
            kegelbruder.setKugelFallenLassen(1);
            await DBProvider.db.updateKegelbruder(kegelbruder);
            break;
          case "Alle Neune":
            kegelbruderListe.forEach((element) async {
              if (element.abwesend == 1) {
                return;
              }
              if (element.unabgemeldet == 1) {
                return;
              }
              if (element.isSelected == 0) {
                element.setAlleNeune(1);
                await DBProvider.db.updateKegelbruder(element);
              }
            });
            break;
          default:
            break;
        }
        return;
      }
      notifyListeners();
    });
  }

  // set Strafen for selected Player lower
  void setStrafenLower(int index, String strafen) async {
    // get all Kegelbruder from DB
    List<Kegelbruder> kegelbruderListe =
        await DBProvider.db.getAllKegelbruder();

    // get strafenliste from kegelbruder an loop through until he is no longer selected
    kegelbruderListe.forEach((kegelbruder) async {
      while (kegelbruder.isSelected == 1) {
        switch (strafen) {
          case "Pumpe":
            kegelbruder.setPumpe(-1);
            await DBProvider.db.updateKegelbruder(kegelbruder);
            print("pumpe" + kegelbruder.pumpe.toString());
            break;
          case "Klingeln":
            kegelbruder.setKlingeln(-1);
            await DBProvider.db.updateKegelbruder(kegelbruder);
            print("klingeln" + kegelbruder.klingeln.toString());
            break;
          case "3 mittig":
            kegelbruder.setMittenDurch(-1);
            await DBProvider.db.updateKegelbruder(kegelbruder);
            print("stina" + kegelbruder.stina.toString());
            break;
          case "Durchwurf":
            kegelbruder.setDurchWurf(-1);
            await DBProvider.db.updateKegelbruder(kegelbruder);
            print("durchwurf" + kegelbruder.durchwurf.toString());
            break;
          case "Handy":
            kegelbruder.setHandy(-1);
            await DBProvider.db.updateKegelbruder(kegelbruder);
            print("handy" + kegelbruder.handy.toString());
            break;
          case "Kugel bringen":
            kegelbruder.setKugelBringen(-1);
            await DBProvider.db.updateKegelbruder(kegelbruder);
            print("kugelbringen" + kegelbruder.kugelBringen.toString());
            break;
          case "Zu 2. auf der Bahn":
            kegelbruder.setZuZweitaufDerBahn(-1);
            await DBProvider.db.updateKegelbruder(kegelbruder);
            print("zu2." + kegelbruder.zweiPersonenAufDerBahn.toString());
            break;
          case "Lustwurf":
            kegelbruder.setLustwurf(-1);
            await DBProvider.db.updateKegelbruder(kegelbruder);
            print("lustwurf" + kegelbruder.lustwurf.toString());
            break;
          case "Kugel zum Klo":
            kegelbruder.setKugelZumKli(-1);
            await DBProvider.db.updateKegelbruder(kegelbruder);
            break;
          case "Kugel fallenlassen":
            kegelbruder.setKugelFallenLassen(-1);
            await DBProvider.db.updateKegelbruder(kegelbruder);
            break;
          case "Alle Neune":
            kegelbruderListe.forEach((element) async {
              if (element.isSelected == 0) {
                element.setAlleNeune(1);
                await DBProvider.db.updateKegelbruder(element);
              }
            });
            break;
          default:
            break;
        }
        return;
      }
      notifyListeners();
    });
  }

  Future<String> getStrafenCount(String strafe) async {
    Kegelbruder selectedPlayer = await DBProvider.db.getSelectedKegelbruder();
    switch (strafe) {
      case "Pumpe":
        return selectedPlayer.pumpe.toString();
        break;
      case "Klingeln":
        return selectedPlayer.klingel.toString();
        break;
      case "3 mittig":
        return selectedPlayer.mittenDurch.toString();
        break;
      case "Durchwurf":
        return selectedPlayer.durchWurf.toString();
        break;
      case "Handy":
        return selectedPlayer.telefon.toString();
        break;
      case "Kugel bringen":
        return selectedPlayer.kugelbringen.toString();
        break;
      case "Zu 2. auf der Bahn":
        return selectedPlayer.zuZweitaufDerBahn.toString();
        break;
      case "Lustwurf":
        return selectedPlayer.lustWurf.toString();
        break;
      case "Kugel zum Klo":
        return selectedPlayer.kugelKlo.toString();
        break;
      case "Kugel fallenlassen":
        return selectedPlayer.kugelFallenLassen.toString();
        break;
      case "Alle Neune":
        return selectedPlayer.alleNeune.toString();
        break;
      default:
        break;
    }
    notifyListeners();
    return "    ";
  }

  //reset strafen for all Player
  void startNewSession() async {
    //get all Kegelbruder from Database
    List<Kegelbruder> allKegelbruder = await DBProvider.db.getAllKegelbruder();

    //set all strafen entrys == 0
    allKegelbruder.forEach((player) async {
      resetStrafen(player);
      await DBProvider.db.updateKegelbruder(player);
    });
    notifyListeners();
  }

  //create bars for own bar chart in SessionOverviewDialog
  Widget createBars(String strafe, List<Kegelbruder> kegelbruderListe,
      Kegelbruder kegelbruder) {
    switch (strafe) {
      case "Pumpe":
        List<int> strafenCountListe = [];
        kegelbruderListe.forEach((kegelbruder) {
          strafenCountListe.add(kegelbruder.pumpe);
        });
        int maxStrafenCount = strafenCountListe[0];
        strafenCountListe.forEach((count) {
          if (count > maxStrafenCount) {
            maxStrafenCount = count;
          }
        });
        int currentCount = kegelbruder.pumpe;
        double barWidth = calculateBarWidth(maxStrafenCount, currentCount);
        Widget bar = singleBar(
            barWidth, currentCount, maxStrafenCount, kegelbruder.name);
        return bar;
        break;

      case "Klingeln":
        List<int> strafenCountListe = [];
        kegelbruderListe.forEach((kegelbruder) {
          strafenCountListe.add(kegelbruder.klingeln);
        });
        int maxStrafenCount = strafenCountListe[0];
        strafenCountListe.forEach((count) {
          if (count > maxStrafenCount) {
            maxStrafenCount = count;
          }
        });
        int currentCount = kegelbruder.klingeln;
        double barWidth = calculateBarWidth(maxStrafenCount, currentCount);
        Widget bar = singleBar(
            barWidth, currentCount, maxStrafenCount, kegelbruder.name);
        return bar;
        break;

      case "3 mittig":
        List<int> strafenCountListe = [];
        kegelbruderListe.forEach((kegelbruder) {
          strafenCountListe.add(kegelbruder.stina);
        });
        int maxStrafenCount = strafenCountListe[0];
        strafenCountListe.forEach((count) {
          if (count > maxStrafenCount) {
            maxStrafenCount = count;
          }
        });
        int currentCount = kegelbruder.stina;
        double barWidth = calculateBarWidth(maxStrafenCount, currentCount);
        Widget bar = singleBar(
            barWidth, currentCount, maxStrafenCount, kegelbruder.name);
        return bar;
        break;

      case "Durchwurf":
        List<int> strafenCountListe = [];
        kegelbruderListe.forEach((kegelbruder) {
          strafenCountListe.add(kegelbruder.durchwurf);
        });
        int maxStrafenCount = strafenCountListe[0];
        strafenCountListe.forEach((count) {
          if (count > maxStrafenCount) {
            maxStrafenCount = count;
          }
        });
        int currentCount = kegelbruder.durchwurf;
        double barWidth = calculateBarWidth(maxStrafenCount, currentCount);
        Widget bar = singleBar(
            barWidth, currentCount, maxStrafenCount, kegelbruder.name);
        return bar;
        break;

      case "Handy":
        List<int> strafenCountListe = [];
        kegelbruderListe.forEach((kegelbruder) {
          strafenCountListe.add(kegelbruder.handy);
        });
        int maxStrafenCount = strafenCountListe[0];
        strafenCountListe.forEach((count) {
          if (count > maxStrafenCount) {
            maxStrafenCount = count;
          }
        });
        int currentCount = kegelbruder.handy;
        double barWidth = calculateBarWidth(maxStrafenCount, currentCount);
        Widget bar = singleBar(
            barWidth, currentCount, maxStrafenCount, kegelbruder.name);
        return bar;
        break;

      case "Kugel bringen":
        List<int> strafenCountListe = [];
        kegelbruderListe.forEach((kegelbruder) {
          strafenCountListe.add(kegelbruder.kugelBringen);
        });
        int maxStrafenCount = strafenCountListe[0];
        strafenCountListe.forEach((count) {
          if (count > maxStrafenCount) {
            maxStrafenCount = count;
          }
        });
        int currentCount = kegelbruder.kugelBringen;
        double barWidth = calculateBarWidth(maxStrafenCount, currentCount);
        Widget bar = singleBar(
            barWidth, currentCount, maxStrafenCount, kegelbruder.name);
        return bar;
        break;

      case "Zu 2. auf der Bahn":
        List<int> strafenCountListe = [];
        kegelbruderListe.forEach((kegelbruder) {
          strafenCountListe.add(kegelbruder.zweiPersonenAufDerBahn);
        });
        int maxStrafenCount = strafenCountListe[0];
        strafenCountListe.forEach((count) {
          if (count > maxStrafenCount) {
            maxStrafenCount = count;
          }
        });
        int currentCount = kegelbruder.zweiPersonenAufDerBahn;
        double barWidth = calculateBarWidth(maxStrafenCount, currentCount);
        Widget bar = singleBar(
            barWidth, currentCount, maxStrafenCount, kegelbruder.name);
        return bar;
        break;

      case "Lustwurf":
        List<int> strafenCountListe = [];
        kegelbruderListe.forEach((kegelbruder) {
          strafenCountListe.add(kegelbruder.lustwurf);
        });
        int maxStrafenCount = strafenCountListe[0];
        strafenCountListe.forEach((count) {
          if (count > maxStrafenCount) {
            maxStrafenCount = count;
          }
        });
        int currentCount = kegelbruder.lustwurf;
        double barWidth = calculateBarWidth(maxStrafenCount, currentCount);
        Widget bar = singleBar(
            barWidth, currentCount, maxStrafenCount, kegelbruder.name);
        return bar;
        break;

      case "Kugel zum Klo":
        List<int> strafenCountListe = [];
        kegelbruderListe.forEach((kegelbruder) {
          strafenCountListe.add(kegelbruder.kugelKlo);
        });
        int maxStrafenCount = strafenCountListe[0];
        strafenCountListe.forEach((count) {
          if (count > maxStrafenCount) {
            maxStrafenCount = count;
          }
        });
        int currentCount = kegelbruder.kugelKlo;
        double barWidth = calculateBarWidth(maxStrafenCount, currentCount);
        Widget bar = singleBar(
            barWidth, currentCount, maxStrafenCount, kegelbruder.name);
        return bar;
        break;

      case "Kugel fallenlassen":
        List<int> strafenCountListe = [];
        kegelbruderListe.forEach((kegelbruder) {
          strafenCountListe.add(kegelbruder.kugelFallenLassen);
        });
        int maxStrafenCount = strafenCountListe[0];
        strafenCountListe.forEach((count) {
          if (count > maxStrafenCount) {
            maxStrafenCount = count;
          }
        });
        int currentCount = kegelbruder.kugelFallenLassen;
        double barWidth = calculateBarWidth(maxStrafenCount, currentCount);
        Widget bar = singleBar(
            barWidth, currentCount, maxStrafenCount, kegelbruder.name);
        return bar;
        break;

      case "Alle Neune":
        List<int> strafenCountListe = [];
        kegelbruderListe.forEach((kegelbruder) {
          strafenCountListe.add(kegelbruder.alleNeune);
        });
        int maxStrafenCount = strafenCountListe[0];
        strafenCountListe.forEach((count) {
          if (count > maxStrafenCount) {
            maxStrafenCount = count;
          }
        });
        int currentCount = kegelbruder.alleNeune;
        double barWidth = calculateBarWidth(maxStrafenCount, currentCount);
        Widget bar = singleBar(
            barWidth, currentCount, maxStrafenCount, kegelbruder.name);
        return bar;
        break;
    }
    notifyListeners();
  }

  //calculate bar width in relation to highest strafen count
  double calculateBarWidth(int maxCount, int currentCount) {
    double maxWidth = 100;
    double newWidth;
    if (maxCount != 0) {
      newWidth = (maxWidth / maxCount) * currentCount;
    } else {
      newWidth = 0;
    }
    notifyListeners();
    return newWidth;
  }

  //create single Bar for player
  Widget singleBar(
      double barWidth, int currentCount, int maxStrafenCount, String name) {
    if (currentCount == maxStrafenCount) {
      return DynamicBar(
        barWidth: barWidth,
        playerName: name,
        count: currentCount,
      );
    } else {
      return DynamicBar(
        barWidth: barWidth,
        playerName: name,
        count: currentCount,
      );
    }
  }
}
