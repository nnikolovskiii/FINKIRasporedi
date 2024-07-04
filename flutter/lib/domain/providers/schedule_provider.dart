import 'package:flutter/foundation.dart';

class ScheduleProvider with ChangeNotifier {
  bool _isDefault = true;
  String _name = "";

  bool get isDefault => _isDefault;
  String get name => _name;

  void setIsDefault(bool value) {
    _isDefault = value;
    notifyListeners();
  }

  void setName(String value) {
    _name = value;
    notifyListeners();
  }
}
