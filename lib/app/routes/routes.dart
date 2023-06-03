import 'package:conexion/ui/screens/screens.dart';
import 'package:conexion/ui/screens/services_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String login = '/login';
  static const String home = '/home';
  static const String combustible = 'Combustibles';
  static const String servicios = 'Servicios';
  static const String dashboard = 'Dashboard';
  static const String setting = '/setting';
}

Map<String, WidgetBuilder> getRoutes() {
  return {
    AppRoutes.login: (BuildContext context) => LoginScreen(),
    AppRoutes.home: (BuildContext context) => HomePage(),
    AppRoutes.combustible: (BuildContext context) => CombustiblePage(),
    AppRoutes.setting: (BuildContext context) => SettingDBScreen(),
    AppRoutes.servicios: (BuildContext context) => ServiciosPage(),
    AppRoutes.dashboard: (BuildContext context) => DashboardScreen(),
  };
}
