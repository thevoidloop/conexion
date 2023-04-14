import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.amber.shade300),
            child: const Text(
              'Drawer Menu',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ExpansionTile(
            title: Text('Opción 1'),
            children: [
              ListTile(
                title: Text('Subopción 1.1'),
                onTap: () {
                  // Navegar a la pantalla correspondiente
                },
              ),
              ListTile(
                title: Text('Subopción 1.2'),
                onTap: () {
                  // Navegar a la pantalla correspondiente
                },
              ),
            ],
          ),
          ListTile(
            title: Text('Opción 2'),
            onTap: () {
              // Navegar a la pantalla correspondiente
            },
          ),
          ListTile(
            title: Text('Opción 3'),
            onTap: () {
              // Navegar a la pantalla correspondiente
            },
          ),
          ExpansionTile(
            title: Text('Opción 4'),
            children: [
              ListTile(
                title: Text('Subopción 4.1'),
                onTap: () {
                  // Navegar a la pantalla correspondiente
                },
              ),
              ListTile(
                title: Text('Subopción 4.2'),
                onTap: () {
                  // Navegar a la pantalla correspondiente
                },
              ),
            ],
          ),
          ListTile(
            title: Text('Opción 5'),
            onTap: () {
              // Navegar a la pantalla correspondiente
            },
          ),
        ],
      ),
    );
  }
}
