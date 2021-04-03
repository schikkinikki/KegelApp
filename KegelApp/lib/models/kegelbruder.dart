import 'package:flutter/widgets.dart';

class Kegelbruder extends ChangeNotifier {
  String id;
  String name;
  bool isKing;
  bool isPumpenKing;
  bool isSelected = false;
  bool anwesenheit;
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
      this.anwesenheit,
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

  bool get erschienen {
    return anwesenheit;
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
}
