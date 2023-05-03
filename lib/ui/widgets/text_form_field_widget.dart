import 'package:conexion/data/providers/ui_provider.dart';
import 'package:conexion/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TextFormFieldNumber extends StatelessWidget {
  
  final TextEditingController controller;
  final String mensaje;
  
  const TextFormFieldNumber(
    {
    super.key,
    required this.mensaje, 
    required this.controller
  });

  @override
  Widget build(BuildContext context) {
    
    return TextFormField(
      controller: controller,
      decoration:  InputDecoration(
        labelText: mensaje
        
      ),
      keyboardType: TextInputType.number,
    );
  }
}

class TextFormFieldEmail extends StatelessWidget {
  
  final TextEditingController controller;
  final String mensaje;
  
  const TextFormFieldEmail({
    super.key,
    required this.controller, required this.mensaje,
  });


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: mensaje),
      keyboardType: TextInputType.emailAddress,
      validator: validateEmail
    );
  }
}

class TextFormFieldPass extends StatelessWidget {
  
final TextEditingController controller;
final String mensaje;
final bool validator;  

  const TextFormFieldPass({
    super.key, required this.controller, 
    required this.mensaje, 
    this.validator = false,
  });


  @override
  Widget build(BuildContext context) {
    
    
    return ChangeNotifierProvider(
      create: (context) => UIProvider(),
      child: Consumer<UIProvider>(
        builder: (context, ui, child) {
          return TextFormField(
            controller: controller,
            decoration: InputDecoration(
              labelText: mensaje,
              suffixIcon: IconButton(
                icon: ui.obscureText ? const Icon(Icons.visibility_sharp) : const Icon(Icons.visibility_off_sharp),
                onPressed: ui.toggleObscureText,
            ),
            ),
            obscureText: ui.obscureText,
            validator: validator ? null : validatePassword
          );
        },
      )
    );
  }
}
    
class TextFormFieldText extends StatelessWidget {
  
  final TextEditingController controller;
  final String mensaje;

  const TextFormFieldText({
    super.key,
    required this.mensaje, 
    required this.controller
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: mensaje
      ),
      keyboardType: TextInputType.text,
    );
  }
}

class TextFormFielDate extends StatelessWidget {
  TextFormFielDate({super.key});

  final TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UIProvider(),
      child: Consumer<UIProvider>(
        builder: (context, ui, child) {
          return TextFormField(
            controller: _dateController,
            decoration: InputDecoration(
              labelText: 'Selecciona una fecha',
              suffixIcon: IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () => _selectDate(context, ui),
              ),
            ),
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode()); // Ocultar el teclado
              _selectDate(context, ui);
            },
            readOnly: true, // Evita que el teclado aparezca al tocar el campo
          );
        },
      ),
    );
  }
    

    Future<void> _selectDate(BuildContext context, UIProvider ui) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: ui.selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != ui.selectedDate) {
      debugPrint(picked.toString());
      _dateController.text = "${picked.day}/${picked.month}/${picked.year}";
      ui.setSelectedDate(picked);
    }
  }


}