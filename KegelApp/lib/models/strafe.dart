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
}
