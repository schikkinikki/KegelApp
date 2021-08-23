import 'dart:convert';

class Strafe {
  double strafenHoehe;
  String strafenName;

  Strafe({this.strafenName, this.strafenHoehe});

  //Setters
  void setStrafenName(String name) {
    this.strafenName = name;
  }

  void setStrafenHoehe(double strafenSatz) {
    this.strafenHoehe = strafenSatz;
  }

  //database functions
  Strafe clientFromJson(String str) {
    final jsonData = jsonDecode(str);
    return Strafe.fromMap(jsonData);
  }

  String clientToJson(Strafe data) {
    final dyn = data.toMap();
    return json.encode(dyn);
  }

  factory Strafe.fromMap(Map<String, dynamic> json) {
    return Strafe(
      strafenName: json["strafenName"],
      strafenHoehe: json["strafenHoehe"],
    );
  }

  Map<String, dynamic> toMap() {
    return {"strafenName": strafenName, "strafenHoehe": strafenHoehe};
  }

  //creating intital set of strafen
  List<Strafe> initialStrafenListe = [
    Strafe(strafenName: "Pumpe", strafenHoehe: 0.1),
    Strafe(strafenName: "Klingeln", strafenHoehe: 0.1),
    Strafe(strafenName: "3 mittig", strafenHoehe: 0.2),
    Strafe(strafenName: "Durchwurf", strafenHoehe: 0.5),
    Strafe(strafenName: "Handy", strafenHoehe: 5.0),
    Strafe(strafenName: "Kugel bringen", strafenHoehe: 1.0),
    Strafe(strafenName: "Zu 2. auf der Bahn", strafenHoehe: 1.0),
    Strafe(strafenName: "Lustwurf", strafenHoehe: 0.5),
    Strafe(strafenName: "Kugel zum Klo", strafenHoehe: 2.5),
    Strafe(strafenName: "Kugel fallenlassen", strafenHoehe: 1.0),
    Strafe(strafenName: "Alle Neune", strafenHoehe: 0.1),
  ];

  List<Strafe> getIntitialData() {
    return initialStrafenListe;
  }
}
