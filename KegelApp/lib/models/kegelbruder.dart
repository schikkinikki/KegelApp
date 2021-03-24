import 'package:flutter/widgets.dart';

class Kegelbruder extends ChangeNotifier {
  String id;
  String name;
  bool isKing;
  bool isPumpenKing;
  bool isSelected = false;

  Kegelbruder.c2();

  Kegelbruder({
    this.id,
    @required this.name,
    this.isKing,
    this.isPumpenKing,
  });

  Kegelbruder get spieler {
    return spieler;
  }

  void setSelected() {
    if (!isSelected) {
      isSelected = true;
    }
    notifyListeners();
  }
}
