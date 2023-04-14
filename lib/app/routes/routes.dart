import 'package:conexion/ui/screens/screens.dart';
import 'package:flutter/material.dart';




class AppRoutes {
  static const String login = '/login';
  static const String home = '/home';
  static const String combustible = '/combustible';
  static const String setting = '/setting';
}


Map<String, WidgetBuilder> getRoutes() {
  return {
    AppRoutes.login: (BuildContext context) => LoginScreen(),
    AppRoutes.home: (BuildContext context) => HomePage(),
    AppRoutes.combustible: (BuildContext context) => CombustiblePage(),
    AppRoutes.setting: (BuildContext context) => SettingDBScreen(),
  };
}