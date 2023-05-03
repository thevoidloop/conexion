import 'package:conexion/data/models/vehicle_model.dart';
import 'package:conexion/data/providers/database_manager_provider.dart';
import 'package:conexion/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CombustiblePage extends StatefulWidget {
  const CombustiblePage({super.key});

  @override
  State<CombustiblePage> createState() => _CombustiblePageState();
}

class _CombustiblePageState extends State<CombustiblePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Combustibles'),
      ),
      body: SingleChildScrollView(
        child: _FormFuelLog(),
      ),
    );
  }
}

class _FormFuelLog extends StatelessWidget {

    final TextEditingController _numbreValeController = TextEditingController();

  
  _FormFuelLog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        child: Column(
          children: [
            _DropdownButton(),
            TextFormFieldNumber(mensaje: 'Numero de vale', controller: _numbreValeController),
            TextFormFielDate()
          ],
        ),
      ),
    );
  }
}

class _DropdownButton extends StatelessWidget {
  const _DropdownButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseManagerProvider>(builder: (context, db, child) {

      return DropdownButtonFormField(
      items: _buildDrawerItems(db.vehicle),
      value: db.valueVehicle,
      onChanged: (value) {
        db.valueVehicle = value;
      },
      decoration: const InputDecoration(
        labelText: 'Selecciona una opción',
      ),
    );

    });
  }
}



List<DropdownMenuItem> _buildDrawerItems(List<Vehicle> drawerItems) {
  
  List<DropdownMenuItem> items = [];

  items.add(
      DropdownMenuItem(
        value: 'Seleccione una opcion',
        child: Text("Seleccione una opcion", style: TextStyle(fontSize: 18),),
        onTap: () {},
      ),
    );
  
  
  for (var item in drawerItems) {
    items.add(
      DropdownMenuItem(
        value: item.idVehicle.toString(),
        child: Text("${item.marca} ${item.modelo} - ${item.placa}", style: TextStyle(fontSize: 18),),

      ),
    );
  }

  return items;
}

