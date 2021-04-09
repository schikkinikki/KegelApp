import 'package:flutter/widgets.dart';

class Kegelbruder extends ChangeNotifier {
  String id;
  String name;
  bool isKing;
  bool isPumpenKing;
  bool isSelected = false;
  int pumpe;
  int klingeln;
  int stina;
  int durchwurf;
  int handy;
  int kugelBringen;
  int zweiPersonenAufDerBahn;
  int lustwurf;

  Kegelbruder.c2();

  Kegelbruder(
      {this.id,
      @required this.name,
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

  set set_pumpe(int pumpe) {
    this.pumpe = pumpe;
  }

  set set_klingeln(int klingeln) {
    this.klingeln = klingeln;
  }

  set set_mittenDurch(int mittenDurch) {
    this.stina = mittenDurch;
  }

  set set_durchWurf(int durchWurf) {
    this.durchwurf = durchwurf;
  }

  set set_handy(int handy) {
    this.handy = handy;
  }

  set set_kugelBringen(int kugelBringen) {
    this.kugelBringen = kugelBringen;
  }

  set set_lustwurf(int lustWurf) {
    this.lustwurf = lustWurf;
  }

  set set_zuZweitaufDerBahn(int zuZweitaufDerBahn) {
    this.zweiPersonenAufDerBahn = zuZweitaufDerBahn;
  }
}
