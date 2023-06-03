import 'package:conexion/data/models/combustible_model.dart';
import 'package:conexion/data/models/models.dart';
import 'package:conexion/data/models/vehicle_model.dart';
import 'package:conexion/data/providers/database_manager_provider.dart';
import 'package:conexion/data/providers/ui_provider.dart';
import 'package:conexion/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TextFormFieldNumber extends StatelessWidget {
  final TextEditingController controller;
  final String mensaje;

  const TextFormFieldNumber(
      {super.key, required this.mensaje, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: mensaje),
      keyboardType: TextInputType.number,
    );
  }
}

class TextFormFieldEmail extends StatelessWidget {
  final TextEditingController controller;
  final String mensaje;

  const TextFormFieldEmail({
    super.key,
    required this.controller,
    required this.mensaje,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: mensaje),
      keyboardType: TextInputType.emailAddress,
      validator: validateEmail,
    );
  }
}

class TextFormFieldPass extends StatelessWidget {
  final TextEditingController controller;
  final String mensaje;
  final bool validator;

  const TextFormFieldPass({
    super.key,
    required this.controller,
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
                    icon: ui.obscureText
                        ? const Icon(Icons.visibility_sharp)
                        : const Icon(Icons.visibility_off_sharp),
                    onPressed: ui.toggleObscureText,
                  ),
                ),
                obscureText: ui.obscureText,
                validator: validator ? null : validatePassword);
          },
        ));
  }
}

class TextFormFieldText extends StatelessWidget {
  final TextEditingController controller;
  final String mensaje;

  const TextFormFieldText(
      {super.key, required this.mensaje, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: mensaje,
        floatingLabelAlignment: FloatingLabelAlignment.start,
      ),
      keyboardType: TextInputType.text,
      expands: true,
      maxLines: null,
      minLines: null,
    );
  }
}

class TextFormFielDate extends StatelessWidget {
  final TextEditingController dateController;
  TextFormFielDate({super.key, required this.dateController});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UIProvider(),
      child: Consumer<UIProvider>(
        builder: (context, ui, child) {
          return TextFormField(
            controller: dateController,
            decoration: InputDecoration(
              labelText: 'Selecciona una fecha',
              suffixIcon: IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () => _selectDate(context, ui),
              ),
            ),
            onTap: () {
              FocusScope.of(context)
                  .requestFocus(FocusNode()); // Ocultar el teclado
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
      dateController.text = "${picked.day}/${picked.month}/${picked.year}";
      ui.setSelectedDate(picked);
    }
  }
}

class DropdownVehicle extends StatelessWidget {
  const DropdownVehicle({
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
          labelText: 'Vehiculo',
        ),
      );
    });
  }

  List<DropdownMenuItem> _buildDrawerItems(List<Vehicle> drawerItems) {
    List<DropdownMenuItem> items = [];

    items.add(
      const DropdownMenuItem(
        value: 'Seleccione una opcion',
        child: Text(
          "Seleccione una opcion",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );

    for (var item in drawerItems) {
      items.add(
        DropdownMenuItem(
          value: item.idVehicle.toString(),
          child: Text(
            "${item.marca} ${item.modelo} - ${item.placa}",
            style: const TextStyle(fontSize: 18),
          ),
        ),
      );
    }

    return items;
  }
}

class DropdownTypeMant extends StatelessWidget {
  const DropdownTypeMant({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseManagerProvider>(builder: (context, db, _) {
      return DropdownButtonFormField(
        items: _buildDrawerItems(db.typeMan),
        value: db.valueTypeMan,
        onChanged: (value) {
          db.valueTypeMan = value;
        },
        decoration: const InputDecoration(
          labelText: 'Tipo de Mantenimiento',
        ),
      );
    });
  }

  List<DropdownMenuItem> _buildDrawerItems(List<TypeMan> drawerItems) {
    List<DropdownMenuItem> items = [];

    items.add(
      const DropdownMenuItem(
        value: 'Seleccione una opcion',
        child: Text(
          "Seleccione una opcion",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );

    for (var item in drawerItems) {
      items.add(
        DropdownMenuItem(
          value: item.idType.toString(),
          child: Text(
            item.type,
            style: const TextStyle(fontSize: 18),
          ),
        ),
      );
    }

    return items;
  }
}

class DropdownCombustible extends StatelessWidget {
  const DropdownCombustible({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseManagerProvider>(builder: (context, db, child) {
      return DropdownButtonFormField(
        items: _buildDrawerItems(db.combustible),
        value: db.valueCombustible,
        onChanged: (value) {
          db.valueCombustible = value;
        },
        decoration: const InputDecoration(
          labelText: 'Tipo de combustible',
        ),
      );
    });
  }

  List<DropdownMenuItem> _buildDrawerItems(List<Combustible> drawerItems) {
    List<DropdownMenuItem> items = [];

    items.add(
      const DropdownMenuItem(
        value: 'Seleccione una opcion',
        child: Text(
          "Seleccione una opcion",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );

    for (var item in drawerItems) {
      items.add(
        DropdownMenuItem(
          value: item.idCombustible.toString(),
          child: Text(
            item.nombre,
            style: const TextStyle(fontSize: 18),
          ),
        ),
      );
    }

    return items;
  }
}

class DropdownYear extends StatelessWidget {
  const DropdownYear({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseManagerProvider>(builder: (context, db, _) {
      return DropdownButtonFormField(
        items: _buildDrawerItems(),
        value: db.year,
        onChanged: (value) {
          db.year = value;
          db.getDataMes();
        },
        decoration: const InputDecoration(
          labelText: 'Año',
        ),
      );
    });
  }

  List<DropdownMenuItem> _buildDrawerItems() {
    List<DropdownMenuItem> items = [];
    List<String> year = [
      '2020',
      '2021',
      '2022',
      '2023',
      '2024',
      '2025',
    ];

    items.add(
      const DropdownMenuItem(
        value: 0,
        child: Text(
          "Seleccione una opcion",
          style: TextStyle(fontSize: 12),
        ),
      ),
    );

    for (var item in year) {
      items.add(
        DropdownMenuItem(
          value: int.parse(item),
          child: Text(
            item,
            style: const TextStyle(fontSize: 12),
          ),
        ),
      );
    }

    return items;
  }
}

class DropdownSemester extends StatelessWidget {
  const DropdownSemester({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseManagerProvider>(builder: (context, db, _) {
      return DropdownButtonFormField(
        items: _buildDrawerItems(),
        value: db.semester,
        onChanged: (value) {
          db.semester = value;
          db.getDataMes();
        },
        decoration: const InputDecoration(
          labelText: 'Semestre',
        ),
      );
    });
  }

  List<DropdownMenuItem> _buildDrawerItems() {
    List<DropdownMenuItem> items = [];
    List<String> semester = [
      '1',
      '2',
    ];

    items.add(
      const DropdownMenuItem(
        value: 0,
        child: Text(
          "Seleccione una opcion",
          style: TextStyle(fontSize: 12),
        ),
      ),
    );

    for (var item in semester) {
      items.add(
        DropdownMenuItem(
          value: int.parse(item),
          child: Text(
            item,
            style: const TextStyle(fontSize: 12),
          ),
        ),
      );
    }

    return items;
  }
}

class DropdownVehicleData extends StatelessWidget {
  const DropdownVehicleData({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseManagerProvider>(builder: (context, db, child) {
      return DropdownButtonFormField(
        items: _buildDrawerItems(db.vehicle),
        value: db.dataVehicle,
        onChanged: (value) {
          db.dataVehicle = value;
          db.getDataPie();
        },
        decoration: const InputDecoration(
          labelText: 'Vehiculo',
        ),
      );
    });
  }

  List<DropdownMenuItem> _buildDrawerItems(List<Vehicle> drawerItems) {
    List<DropdownMenuItem> items = [];

    items.add(
      const DropdownMenuItem(
        value: 0,
        child: Text(
          "Seleccione una opcion",
          style: TextStyle(fontSize: 12),
        ),
      ),
    );

    for (var item in drawerItems) {
      items.add(
        DropdownMenuItem(
          value: item.idVehicle.toString(),
          child: Text(
            "${item.marca} ${item.modelo} - ${item.placa}",
            style: const TextStyle(fontSize: 12),
          ),
        ),
      );
    }

    return items;
  }
}

class DropdownYearPie extends StatelessWidget {
  const DropdownYearPie({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseManagerProvider>(builder: (context, db, _) {
      return DropdownButtonFormField(
        items: _buildDrawerItems(),
        value: db.yearPie,
        onChanged: (value) {
          db.yearPie = value;
          db.getDataPie();
        },
        decoration: const InputDecoration(
          labelText: 'Año',
        ),
      );
    });
  }

  List<DropdownMenuItem> _buildDrawerItems() {
    List<DropdownMenuItem> items = [];
    List<String> year = [
      '2020',
      '2021',
      '2022',
      '2023',
      '2024',
      '2025',
    ];

    items.add(
      const DropdownMenuItem(
        value: 0,
        child: Text(
          "Seleccione una opcion",
          style: TextStyle(fontSize: 12),
        ),
      ),
    );

    for (var item in year) {
      items.add(
        DropdownMenuItem(
          value: int.parse(item),
          child: Text(
            item,
            style: const TextStyle(fontSize: 12),
          ),
        ),
      );
    }

    return items;
  }
}
