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

  void setStrafen(int index, String strafen) {
    memberlist.forEach((player) {
      List<int> strafenliste = player.strafenListen;
      while (player.isSelected == true) {
        switch (strafen) {
          case "Pumpe":
            strafenliste[index]++;
            player.setPumpe(strafenliste[index]);
            print(player.name + player.pumpen.toString());
            break;
          case "Klingeln":
            strafenliste[index]++;
            player.setKlingeln(strafenliste[index]);
            break;
          case "Stina":
            strafenliste[index]++;
            player.setMittenDurch(strafenliste[index]);
            break;
          case "Durchwurf":
            strafenliste[index]++;
            player.setDurchWurf(strafenliste[index]);
            break;
          case "Handy":
            strafenliste[index]++;
            player.setHandy(strafenliste[index]);
            break;
          case "Kugel bringen":
            strafenliste[index]++;
            player.setKugelBringen(strafenliste[index]);
            break;
          case "Zu 2. auf der Bahn":
            strafenliste[index]++;
            player.setZuZweitaufDerBahn(strafenliste[index]);
            break;
          case "Lustwurf":
            strafenliste[index]++;
            player.setLustwurf(strafenliste[index]);
            break;
          default:
            break;
        }
        return;
      }
    });
    notifyListeners();
  }

  int getOneStrafe(int index) {
    Kegelbruder player = memberlist.firstWhere((element) => element.isSelected,
        orElse: () => new Kegelbruder(name: null));
    return player.getSingleStrafe(index);
  }
}
