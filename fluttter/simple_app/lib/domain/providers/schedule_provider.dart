import 'package:flutter/foundation.dart';

class ScheduleProvider with ChangeNotifier {
  bool _isDefault = true;  // Default value

  bool get isDefault => _isDefault;

  void setIsDefault(bool value) {
    _isDefault = value;
    notifyListeners();
  }
}
