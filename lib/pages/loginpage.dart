import 'package:conexion/DatabaseManager.dart';
import 'package:conexion/pages/homePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const Image(image: AssetImage('assets/login.png'), height: 300),
            _EmailForm(emailController: _emailController),
            SizedBox(height: 16),
            _PassForm(passwordController: _passwordController),
            SizedBox(height: 16),
            _ButtonLogin(formKey: _formKey, emailController: _emailController, passwordController: _passwordController),
          ],
        ),
      ),
    );
  }
}

class _ButtonLogin extends StatelessWidget {
  const _ButtonLogin({
    super.key,
    required GlobalKey<FormState> formKey,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  }) : _formKey = formKey, _emailController = emailController, _passwordController = passwordController;

  final GlobalKey<FormState> _formKey;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed:  () async {
        if (_formKey.currentState!.validate()) {
          
          Provider.of<LoginModel>(context, listen: false).login(
            _emailController.text,
            _passwordController.text,
            context
          );
          
        }
      },
      child: Text('Iniciar sesión'),
    );
  }
}

class _PassForm extends StatelessWidget {
  const _PassForm({
    super.key,
    required TextEditingController passwordController,
  }) : _passwordController = passwordController;

  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _passwordController,
      decoration: InputDecoration(labelText: 'Contraseña'),
      obscureText: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Este campo es obligatorio';
        }
        // Agrega aquí otras validaciones si es necesario
        return null;
      },
    );
  }
}

class _EmailForm extends StatelessWidget {
  const _EmailForm({
    super.key,
    required TextEditingController emailController,
  }) : _emailController = emailController;

  final TextEditingController _emailController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _emailController,
      decoration: const InputDecoration(labelText: 'Correo electrónico'),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Este campo es obligatorio';
        }
        // Agrega aquí otras validaciones si es necesario
        return null;
      },
    );
  }
}

class LoginModel with ChangeNotifier {

DatabaseManager dbManager = DatabaseManager();

  Future<void> login(String email, String password, BuildContext context) async {


    
    await dbManager.connect(context);
    int temp = await dbManager.validarUsario('DECLARE @Valid BIT; EXEC ValidarUsuario @correo  = \'$email\', @pass = \'$password\', @Resultado = @Valid OUTPUT; SELECT @Valid AS Result;');
    

    if (temp==1){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    }else {
      debugPrint('Usuario Invalido');
    }
  }
}