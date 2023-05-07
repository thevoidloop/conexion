import 'package:flutter/material.dart';

class ServiciosPage extends StatelessWidget {
  const ServiciosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Servicios'),
      ),
      body: SingleChildScrollView(
        child: _FormServicesLog(),
      ),
    );
  }
}

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
          children: [],
        ),
      ),
    );
  }
}
