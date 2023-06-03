import 'package:conexion/app/routes/routes.dart';
import 'package:conexion/app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/providers/database_manager_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DatabaseManagerProvider(),
        ),
      ],
      child: MaterialApp(
        initialRoute: AppRoutes.login,
        routes: getRoutes(),
        theme: getAppTheme(),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}
