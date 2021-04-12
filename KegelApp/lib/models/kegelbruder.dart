import 'package:flutter/widgets.dart';

class Kegelbruder extends ChangeNotifier {
  String name;
  bool isKing;
  bool isPumpenKing;
  bool isSelected = false;
  int pumpe = 0;
  int klingeln = 0;
  int stina = 0;
  int durchwurf = 0;
  int handy = 0;
  int kugelBringen = 0;
  int zweiPersonenAufDerBahn = 0;
  int lustwurf = 0;

  Kegelbruder.c2();

  Kegelbruder(
      {@required this.name,
      this.isKing,
      this.isPumpenKing,
      this.pumpe,
      this.klingeln,
      this.stina,
      this.durchwurf,
      this.handy,
      this.kugelBringen,
      this.lustwurf,
      this.zweiPersonenAufDerBahn});

  Kegelbruder get spieler {
    return spieler;
  }

  List<int> strafenListe = [0, 0, 0, 0, 0, 0, 0, 0];

  List<int> get strafenListen {
    return strafenListe;
  }

  int getSingleStrafe(int index) {
    return strafenListe[index];
  }

  void setSelected() {
    if (!isSelected) {
      isSelected = true;
    }
    notifyListeners();
  }

  int get pumpen {
    return pumpe;
  }

  int get klingel {
    return klingeln;
  }

  int get mittenDurch {
    return stina;
  }

  int get durchWurf {
    return durchwurf;
  }

  int get telefon {
    return handy;
  }

  int get kugelbringen {
    return kugelBringen;
  }

  int get zuZweitaufDerBahn {
    return zweiPersonenAufDerBahn;
  }

  int get lustWurf {
    return lustwurf;
  }

  void setPumpe(int strafe) {
    this.pumpe = strafe;
    notifyListeners();
  }

  void setKlingeln(int klingeln) {
    this.klingeln = klingeln;
    notifyListeners();
  }

  void setMittenDurch(int mittenDurch) {
    this.stina = mittenDurch;
    notifyListeners();
  }

  void setDurchWurf(int durchWurf) {
    this.durchwurf = durchwurf;
    notifyListeners();
  }

  void setHandy(int handy) {
    this.handy = handy;
    notifyListeners();
  }

  void setKugelBringen(int kugelBringen) {
    this.kugelBringen = kugelBringen;
    notifyListeners();
  }

  void setLustwurf(int lustWurf) {
    this.lustwurf = lustWurf;
    notifyListeners();
  }

  void setZuZweitaufDerBahn(int zuZweitaufDerBahn) {
    this.zweiPersonenAufDerBahn = zuZweitaufDerBahn;
    notifyListeners();
  }
}
