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

  void changeSelection(Kegelbruder player) {
    memberlist.where((element) {
      if (element.name == player.name) {
        element.setSelected();
      }
      return true;
    });
    notifyListeners();
  }

  List<String> getPlayerNames() {
    List<String> playerNames = [];
    memberlist.forEach((player) {
      playerNames.add(player.name);
    });
    return playerNames;
  }

  Map<String, dynamic> getStrafen(Kegelbruder player) {
    var strafenList = {};
    memberlist.where((element) {
      if (element.name == player.name) {
        strafenList["Anwesenheit"] = element.erschienen;
        strafenList["Pumpe"] = element.pumpen;
        strafenList["Klingeln"] = element.klingel;
        strafenList["Stina"] = element.mittenDurch;
        strafenList["Durchwurf"] = element.durchWurf;
        strafenList["Handy"] = element.telefon;
        strafenList["Kugel bringen"] = element.kugelbringen;
        strafenList["zu Zweit auf Bahn"] = element.zuZweitaufDerBahn;
        strafenList["Lustwurf"] = element.lustWurf;
      }
      return true;
    });
    return strafenList;
  }
}
