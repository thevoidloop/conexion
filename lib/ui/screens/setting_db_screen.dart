import 'package:conexion/data/providers/database_manager_provider.dart';
import 'package:conexion/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingDBScreen extends StatelessWidget {
  const SettingDBScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final TextEditingController _passwordController = TextEditingController();
    final TextEditingController _ipController = TextEditingController();
    final TextEditingController _portController = TextEditingController();
    final TextEditingController _dbNameController = TextEditingController();
    final TextEditingController _userController = TextEditingController();
    
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuracion de la BD'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormFieldNumber(
                  controller: _ipController,
                  mensaje: 'Direccion IP',
                ),
                SizedBox(height: 15,),
                TextFormFieldNumber(
                  controller: _portController,
                  mensaje: 'Puerto de conexion',
                ),
                SizedBox(height: 15,),
                TextFormFieldText(
                  controller: _dbNameController,
                  mensaje: 'Nombre de la Base de Datos',
                ),
                SizedBox(height: 15,),
                TextFormFieldText(
                  controller: _userController,
                  mensaje: 'Usuario',
                ),
                SizedBox(height: 15,),
                TextFormFieldPass(
                  controller: _passwordController, 
                  mensaje: 'Contraseña'
                ),
                SizedBox(height: 15,),
                _ButtonConexion(
                  formKey: _formKey, 
                  dbNameController: _dbNameController, 
                  ipController: _ipController, 
                  passwordController: _passwordController, 
                  portController: _portController, 
                  userController: _userController,

                )
                

              ],
            )
          ),
        ),
      )
    );
  }
}



class _ButtonConexion extends StatelessWidget {
  
  final TextEditingController passwordController;
  final TextEditingController ipController;
  final TextEditingController portController;
  final TextEditingController dbNameController;
  final TextEditingController userController;
  final GlobalKey<FormState> formKey;
  
  
  
  const _ButtonConexion({
    super.key,
    required this.formKey, 
    required this.passwordController, 
    required this.ipController, 
    required this.portController, 
    required this.dbNameController, 
    required this.userController,
  });


  @override
  Widget build(BuildContext context) {
    
    return Consumer<DatabaseManagerProvider> (
      builder: (context, dbmanager, _) {
        return ElevatedButton(
          onPressed: () async {
            dbmanager.ip = ipController.text;
            dbmanager.databasename = dbNameController.text;
            dbmanager.port = portController.text;
            dbmanager.username = userController.text;
            dbmanager.password = passwordController.text;

            await dbmanager.connect();
          },
      child: const Text('Conectar'),
    );
      },
    );
  }
}

