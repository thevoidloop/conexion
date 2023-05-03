import 'package:flutter/material.dart';

class UIProvider extends ChangeNotifier {
  
  bool _obscureText = true;
  DateTime _selectedDate = DateTime.now();
  




  DateTime get selectedDate => _selectedDate;
  bool get obscureText => _obscureText;

  void toggleObscureText() {
    _obscureText = !_obscureText;
    notifyListeners();
  }

  void setSelectedDate(DateTime newDate) {
    _selectedDate = newDate;
    notifyListeners();
  }
}