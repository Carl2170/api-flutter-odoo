
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../services/odoo_service.dart'; // Asegúrate de importar correctamente tu servicio
import 'package:agenda_virtual_app/views/view_alumno.dart';
import '../services/alumno_api_rest.dart';
import '../services/shared_preferences.dart';
import 'package:odoo_rpc/odoo_rpc.dart';

final client= OdooClient('http://10.0.2.2:8085/');
String name = "carlitos@gmail.com";
String password = "123456";
String db = "colegio_Odoo";

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // late OdooService odooService;
  final ApiRest apiService =ApiRest(baseUrl: 'http://10.0.2.2:8085/api/login',dataBase: 'colegio_Odoo');
  bool isLoading = false;


    @override
    void initState() {
      super.initState();
    }

    Future<void> _login() async {
    try {
      final sessionData= await apiService.login(_usernameController.text,_passwordController.text);
      // Verifica si la autenticación fue exitosa
      if (sessionData.isNotEmpty) {

        if (!mounted) return; // Verifica si el widget está montado
        // Navega a la vista de alumnos
          final sid = sessionData['sid'];
          final uid = sessionData['uid'];
         print("session id login : $sid");

          SharedPreferencesService.prefs.setString('sessionId', sid);
          SharedPreferencesService.prefs.setInt('userId', uid);
          SharedPreferencesService.prefs.setString('password', _passwordController.text);
        
        await apiService.fetchAlumnos();
          
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (context) => const AlumnoScreen()), // Reemplaza AlumnosView() por tu vista de alumnos

        // );
      } else {
        // Autenticación fallida
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Autenticación fallida. Verifique sus credenciales.')));
      }
    } catch (e) {
      if (!mounted) return; // Verifica si el widget está montado
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login failed: $e'),duration:const Duration(seconds: 5),));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio de sesión'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Nombre de usuario',
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Contraseña',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Iniciar sesión'),
            ),
          ],
        ),
      ),
    );
  }
}
