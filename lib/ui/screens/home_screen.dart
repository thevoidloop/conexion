//import 'package:conexion/widgets/drawer/CustomDrawer.dart';
import 'package:conexion/data/models/option_model.dart';
import 'package:conexion/data/providers/database_manager_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('CONTROL AUTOMOVILES'),
        ),
        drawer: _buildDrawer(),
        body: Container());
  }
}

class _buildDrawer extends StatelessWidget {
  const _buildDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: _buildDrawerItems(context),
      ),
    );
  }
}

List<Widget> _buildDrawerItems(BuildContext context) {
  List<Widget> items = [
    const DrawerHeader(
      decoration: BoxDecoration(color: Colors.black45),
      child: Center(
          child: Text('EMPRESA S.A.',
              style: TextStyle(color: Colors.white, fontSize: 24))),
    ),
  ];

  DatabaseManagerProvider db =
      Provider.of<DatabaseManagerProvider>(context, listen: false);

  List<Option> drawerItems = db.options;

  // Genera los ListTile a partir de la lista de elementos
  for (var item in drawerItems) {
    items.add(
      ListTile(
        //leading: Icon(item[]),
        title: Text(
          item.optionName,
          style: const TextStyle(fontSize: 18),
        ),
        onTap: () {
          db.defaultSettings();
          Navigator.pushNamed(context, item.optionName);
        },
      ),
    );
  }

  return items;
}
