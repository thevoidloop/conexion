import 'package:conexion/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';

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
  final TextEditingController _galonesController = TextEditingController();
  final TextEditingController _kilometrosController = TextEditingController();
  final TextEditingController _totalController = TextEditingController();

  _FormFuelLog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            const DropdownVehicle(),
            const SizedBox(height: 15),
            TextFormFieldNumber(
              mensaje: 'Numero de vale',
              controller: _numbreValeController,
            ),
            const SizedBox(height: 15),
            TextFormFielDate(),
            const SizedBox(height: 15),
            const DropdownCombustible(),
            const SizedBox(height: 15),
            TextFormFieldNumber(
              mensaje: 'Cantidad de galones',
              controller: _galonesController,
            ),
            const SizedBox(height: 15),
            TextFormFieldNumber(
              mensaje: 'Kilometráje del vehiculo',
              controller: _kilometrosController,
            ),
            const SizedBox(height: 15),
            TextFormFieldNumber(
              mensaje: 'Total del vale',
              controller: _totalController,
            ),
            const SizedBox(height: 40),
            const _SaveButton()
          ],
        ),
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: const Text(
        'Guardar Registro',
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
