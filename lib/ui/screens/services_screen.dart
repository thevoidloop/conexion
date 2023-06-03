import 'package:conexion/data/providers/database_manager_provider.dart';
import 'package:conexion/ui/widgets/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ServiciosPage extends StatelessWidget {
  const ServiciosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Servicios'),
      ),
      body: const SingleChildScrollView(
        child: _FormServicesLog(),
      ),
    );
  }
}

final TextEditingController _descripcionController = TextEditingController();
final TextEditingController _dateController = TextEditingController();

class _FormServicesLog extends StatelessWidget {
  const _FormServicesLog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownVehicle(),
            TextFormFielDate(dateController: _dateController),
            //OpcionesMante(),
            Container(
              height: 75,
              child: TextFormFieldText(
                mensaje: 'Descripcion del mantenimiento realizado',
                controller: _descripcionController,
              ),
            ),
            DropdownTypeMant(),
            Padding(padding: const EdgeInsets.all(40), child: _SaveButton())
          ],
        ),
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  _SaveButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await Provider.of<DatabaseManagerProvider>(context, listen: false)
            .ingresarRegistroServicio(
          _dateController.text,
          _descripcionController.text,
        );
      },
      child: const Text(
        'Guardar Registro',
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
