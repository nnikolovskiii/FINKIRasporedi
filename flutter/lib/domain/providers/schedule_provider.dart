import 'package:flutter/foundation.dart';

class ScheduleProvider with ChangeNotifier {
  bool _isDefault = true;
  String _name = "";
  String _professor = "stefan.andonov";
  String _room = "112 ФЕИТ";

  bool get isDefault => _isDefault;

  String get name => _name;

  String get professor => _professor;

  String get room => _room;

  void setIsDefault(bool value) {
    _isDefault = value;
    notifyListeners();
  }

  void setName(String value) {
    _name = value;
    notifyListeners();
  }

  void setProfessor(String value) {
    _professor = value;
    notifyListeners();
  }

  void setRoom(String value) {
    _room = value;
    notifyListeners();
  }
}
