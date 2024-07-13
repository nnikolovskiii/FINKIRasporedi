import 'package:flutter/foundation.dart';

class ScheduleProvider with ChangeNotifier {
  bool _isDefault = true;
  String _name = "";
  String _professor = "stefan.andonov";

  bool get isDefault => _isDefault;
  String get name => _name;
  String get professor => _professor;


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
}
