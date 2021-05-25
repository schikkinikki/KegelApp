import 'package:KegelApp/database/kegelAppDatabase.dart';
import 'package:flutter/cupertino.dart';

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

// set Strafen for selected Player higher
  void setStrafen(int index, String strafen) async {
    // get all Kegelbruder from DB
    List<Kegelbruder> kegelbruderListe =
        await DBProvider.db.getAllKegelbruder();

    // get strafenliste from kegelbruder an loop through until he is // no longer selected
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
          case "Stina":
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

    // get strafenliste from kegelbruder an loop through until he is // no longer selected
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
          case "Stina":
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
      case "Stina":
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
      default:
        break;
    }
    notifyListeners();
    return "    ";
  }
}
