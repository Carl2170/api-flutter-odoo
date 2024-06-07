import 'dart:convert';
import '../services/shared_preferences.dart';
import 'package:http/http.dart' as http;
// import '../models/alumno.dart';

class ApiRest {
  final String baseUrl;
  final String dataBase;

  ApiRest({required this.baseUrl, required this.dataBase});

  Future<void> fetchAlumnos() async {
  final sessionId = SharedPreferencesService.prefs.getString('sessionId');

  final url = Uri.parse('http://10.0.2.2:8085/jsonrpc'); //el emulador usa esa ip
  final headers = {
    'Content-Type': 'application/json', 
    'Cookie': 'frontend_lang=es_BO;session_id=$sessionId',
  };
    final password = SharedPreferencesService.prefs.getString('password');
    final userId = SharedPreferencesService.prefs.getInt('userId');

  final params = {"service":"object",
                     "method":"execute",
                     "args": [
                      "colegio_Odoo", //base de datos
                      userId,//id del usuario
                      password, //contraseña ni idea de por que pide esta wea
                      "administracion_academica.curso", //modelo o clase 
                      "search_read", // pa buscar y leer creo
                      [],
                      []
                     ]
                  };

  final client = http.Client();
  try {
    final response = await client.post(
      url,
      
      headers: headers,
      body: jsonEncode({
      'jsonrpc': '2.0',
      'method': 'call',
      'params': params}),
    );

    print('Request Headers: ${response.request?.headers}');
    // print('Request Body: ${response.request?.body}');
    print('Response Status: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('Success: ${data['result']}');
    } else {
      print('Failed: ${response.body}');
    }
  } finally {
    client.close();
  }
}
  Future<Map<String, dynamic>> getAlumno() async {
   //  final params = {'db': SharedPreferencesService.prefs.getString('sessionId'), 'login': login, 'password': password};
    
    final password = SharedPreferencesService.prefs.getString('password');
    final userId = SharedPreferencesService.prefs.getInt('userId');
    final params = {"service":"object",
                     "method":"execute",
                     "args": [
                      "colegio_Odoo",
                      userId,
                      password,
                      "administracion_academica_alumno",
                      "search_read",
                      [],
                      []
                     ]
                  };
    final sessionId = SharedPreferencesService.prefs.getString('sessionId');
    final headers = { 'Cookie':'frontend_lang=es_BO;session_id=$sessionId','Content-type': 'application/json'};
    final uri = Uri.parse('http://10.0.2.2:8085/jsonrpc');
    final body = json.encode({
      'jsonrpc': '2.0',
      'method': 'call',
      'params': params,
      // 'id': sha1.convert(utf8.encode(DateTime.now().toString())).toString()
    });

    final response = await http.post(
      uri,
      headers:headers,
      body: body
    );
    var result =json.decode(response.body); 
    print(result);
    if( result['error'] != null){
      final error = result['error'].toString();
      print(error);
    }

    if (response.statusCode == 200) {
      print("entre a response");
      // La solicitud fue exitosa, puedes manejar la respuesta aquí
        return result;

    } else {
      throw Exception("error");
    }


  }


  Future<Map<String, dynamic>> login(String username, String password)async{

     Map<String, dynamic> data = {
    "username": username,
    "password": password,
    "db": dataBase
    };

    try {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    // Verificar si la solicitud fue exitosa
    if (response.statusCode == 200) {
      // La solicitud fue exitosa, puedes manejar la respuesta aquí
        return json.decode(response.body)['result']['result'];

    } else {
      throw Exception("error");
    }
  } catch (error) {
    // Ocurrió un error al realizar la solicitud
      throw Exception(error);
  }

  }
  // Future<List<dynamic>> getStudents() async {
    Future <List<Map<String, String>>> getStudents() async{
    final sessionId=  SharedPreferencesService.prefs.getString('sessionId');
    final userId= SharedPreferencesService.prefs.getInt('userId');
    final password= SharedPreferencesService.prefs.getInt('userId');
  try {
     final Uri url = Uri.parse('http://10.0.2.2:8085/jsonrpc/');
   final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Cookie': 'frontend_lang=es_BO; session_id=$sessionId',
  };


final Map<String, dynamic> requestBody = {
  "jsonrpc": "2.0",
  "method": "call",
  "params": {
    "service": "object",
    "method": "execute",
    "args": [
      dataBase,
      userId,
      password,
      "administracion_academica.alumno",
      "search_read",
      [],
      []
    ]
  }
  };

    final response = await http.post(
    url,
    headers: headers,
    body: jsonEncode(requestBody),
  );
   final resRequest =json.decode(response.toString()); 
    print('Response : ${resRequest}');

  if (response.statusCode == 200) {
    print("entre");
      //La solicitud fue exitosa, puedes manejar la respuesta aquí

         List<dynamic> results = json.decode(response.body)['result'];
         print(results);
        List<Map<String, String>> students = results.map((student) {
        return {
          'nombre': student['nombre'].toString(),
          'apellido_paterno': student['apellido_paterno'].toString(),
          'apellido_materno': student['apellido_materno'].toString(),
        };
      }).toList();

      return students;


    } else {
      print("entre por falso");
      // La solicitud no fue exitosa, lanzamos una excepción con el mensaje del servidor
      throw Exception('Error en la solicitud: ${response.reasonPhrase}');
    }
  } catch (e) {
    throw Exception('Mensaje de error: $e' );
  }    
  }



}
