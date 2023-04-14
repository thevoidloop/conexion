import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/loginpage.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => LoginModel(),
      child: MaterialApp(
        home: LoginPage(),
        theme: ThemeData.light().copyWith(
          primaryColorLight: Colors.amber.shade300,
          appBarTheme: AppBarTheme(centerTitle: true,backgroundColor: Colors.amber.shade300,),
          elevatedButtonTheme:  ElevatedButtonThemeData(style: TextButton.styleFrom(
            backgroundColor: Colors.black45
          ))
        ),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LoginForm(),
        ],
      ),
    );
  }
}

