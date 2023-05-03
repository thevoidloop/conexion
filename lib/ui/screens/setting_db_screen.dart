import 'package:conexion/data/providers/database_manager_provider.dart';
import 'package:conexion/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingDBScreen extends StatelessWidget {
  const SettingDBScreen({super.key});

  @override
  Widget build(BuildContext context) {

    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    TextEditingController ipController = TextEditingController();

    
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuracion de la BD'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormFieldNumber(
                  controller: ipController,
                  mensaje: 'Direccion IP',
                ),/*
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
                ),*/
                const SizedBox(height: 15,),
                _ButtonConexion(
                  formKey: formKey, 
                  ipController: ipController, 
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
  

  final TextEditingController ipController;

  final GlobalKey<FormState> formKey;
  
  
  
  const _ButtonConexion({
    super.key,
    required this.formKey, 
    required this.ipController, 

  });


  @override
  Widget build(BuildContext context) {
    
   return Consumer<DatabaseManagerProvider> (
      builder: (context, dbmanager, _) {
        return ElevatedButton(
          onPressed: () async {
            dbmanager.ip = ipController.text;
            debugPrint(dbmanager.ip);
            await dbmanager.connect();
          },
      child: const Text('Conectar'),
    );
      },
    );
  }
}

