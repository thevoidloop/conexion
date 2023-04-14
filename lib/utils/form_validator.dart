String? validateEmail(String? value) {
  // Expresión regular para validar emails
  RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  if (value == null || value.isEmpty) {
    return 'Por favor, ingrese un correo electrónico';
  } else if (!emailRegex.hasMatch(value)) {
    return 'Por favor, ingrese un correo electrónico válido';
  }

  return null;
}

String? validateNotEmpty(String? value) {
  if (value == null || value.isEmpty) {
    return 'Por favor, complete este campo';
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Por favor, ingrese una contraseña';
  } else if (value.length < 6) {
    return 'La contraseña debe tener al menos 6 caracteres';
  }

  return null;
}