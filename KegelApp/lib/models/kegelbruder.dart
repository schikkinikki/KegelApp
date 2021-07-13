import 'package:flutter/widgets.dart';
import 'dart:convert';

class Kegelbruder extends ChangeNotifier {
  String name;
  int isKing = 0;
  int isPumpenKing = 0;
  int isSelected = 0;
  int pumpe = 0;
  int klingeln = 0;
  int stina = 0;
  int durchwurf = 0;
  int handy = 0;
  int kugelBringen = 0;
  int zweiPersonenAufDerBahn = 0;
  int lustwurf = 0;
  int kugelKlo = 0;
  int kugelFallenLassen = 0;
  int alleNeune = 0;

  Kegelbruder.c2();

  Kegelbruder(
      {@required this.name,
      this.isKing = 0,
      this.isPumpenKing = 0,
      this.pumpe = 0,
      this.klingeln = 0,
      this.stina = 0,
      this.durchwurf = 0,
      this.handy = 0,
      this.kugelBringen = 0,
      this.lustwurf = 0,
      this.zweiPersonenAufDerBahn = 0,
      this.kugelKlo = 0,
      this.kugelFallenLassen = 0,
      this.alleNeune = 0,
      this.isSelected = 0});

  Kegelbruder get spieler {
    return spieler;
  }

  Kegelbruder clientFromJson(String str) {
    final jsonData = json.decode(str);
    return Kegelbruder.fromMap(jsonData);
  }

  String clientToJson(Kegelbruder data) {
    final dyn = data.toMap();
    return json.encode(dyn);
  }

  //fromMap for database
  factory Kegelbruder.fromMap(Map<String, dynamic> json) {
    return new Kegelbruder(
        name: json["name"],
        pumpe: json["pumpe"],
        klingeln: json["klingeln"],
        stina: json["stina"],
        durchwurf: json["durchwurf"],
        handy: json["handy"],
        kugelBringen: json["kugelbringen"],
        lustwurf: json["lustwurf"],
        zweiPersonenAufDerBahn: json["zweiPersonenAufDerBahn"],
        kugelKlo: json["kugelKlo"],
        kugelFallenLassen: json["kugelFallenLassen"],
        alleNeune: json["alleNeune"],
        isSelected: json["isSelected"]);
  }

  //Map for database
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "pumpe": pumpe,
      "klingeln": klingeln,
      "stina": stina,
      "durchwurf": durchwurf,
      "handy": handy,
      "kugelbringen": kugelBringen,
      "lustwurf": lustwurf,
      "zweiPersonenAufDerBahn": zweiPersonenAufDerBahn,
      "kugelKlo": kugelKlo,
      "kugelFallenLassen": kugelFallenLassen,
      "alleNeune": alleNeune,
      "isSelected": isSelected
    };
  }

  //change selection, needed for DropDownButton Widget
  void setSelected() {
    if (isSelected == 0) {
      isSelected = 1;
    }
    notifyListeners();
  }

//getters and setters
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

  int get kugelZumKlo {
    return kugelKlo;
  }

  int get kugelFallengelassen {
    return kugelFallenLassen;
  }

  int get alleNeunegeworfen {
    return alleNeune;
  }

  void setPumpe(int strafe) {
    this.pumpe += strafe;
    notifyListeners();
  }

  void setKlingeln(int klingeln) {
    this.klingeln += klingeln;
    notifyListeners();
  }

  void setMittenDurch(int mittenDurch) {
    this.stina += mittenDurch;
    notifyListeners();
  }

  void setDurchWurf(int durchWurf) {
    this.durchwurf += durchWurf;
    notifyListeners();
  }

  void setHandy(int handy) {
    this.handy += handy;
    notifyListeners();
  }

  void setKugelBringen(int kugelBringen) {
    this.kugelBringen += kugelBringen;
    notifyListeners();
  }

  void setLustwurf(int lustWurf) {
    this.lustwurf += lustWurf;
    notifyListeners();
  }

  void setZuZweitaufDerBahn(int zuZweitaufDerBahn) {
    this.zweiPersonenAufDerBahn += zuZweitaufDerBahn;
    notifyListeners();
  }

  void setKugelZumKli(int strafe) {
    this.kugelKlo += strafe;
    notifyListeners();
  }

  void setKugelFallenLassen(int strafe) {
    this.kugelFallenLassen += strafe;
    notifyListeners();
  }

  void setAlleNeune(int strafe) {
    this.alleNeune += strafe;
    notifyListeners();
  }

  double sumAll(Kegelbruder kegelbruder) {
    double sum = 0;
    double pumpenGeld = kegelbruder.pumpe * 0.1;
    double klingelGeld = kegelbruder.klingeln * 0.1;
    double kugelBringenGeld = kegelbruder.kugelBringen * 1.0;
    double handyGeld = kegelbruder.handy * 5.0;
    double zuZweitAufDerBahnGeld = kegelbruder.zweiPersonenAufDerBahn * 1.0;
    double stinaGeld = kegelbruder.stina * 0.2;
    double lustwurfGeld = kegelbruder.lustwurf * 0.5;
    double durchwurfGeld = kegelbruder.durchwurf * 0.5;
    double kugelKloGeld = kegelbruder.kugelKlo * 2.5;
    double kugelFallenLassenGeld = kegelbruder.kugelFallenLassen * 1.0;
    double alleNeuneGeld = kegelbruder.alleNeune * 0.1;

    sum = pumpenGeld +
        klingelGeld +
        kugelBringenGeld +
        handyGeld +
        zuZweitAufDerBahnGeld +
        stinaGeld +
        lustwurfGeld +
        durchwurfGeld +
        kugelKloGeld +
        kugelFallenLassenGeld +
        alleNeuneGeld;

    return sum;
  }
}
