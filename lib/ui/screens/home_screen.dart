//import 'package:conexion/widgets/drawer/CustomDrawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        title: const Text('BEER DELIVERY'),
      ),
      //drawer: const CustomDrawer(),
      body: Container()
    );
  }
}