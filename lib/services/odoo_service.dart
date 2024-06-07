// import 'package:odoo_rpc/odoo_rpc.dart';

// class OdooService {
//   final OdooClient client;
//   late OdooSession session;
//   OdooService() : client = OdooClient('http://10.0.2.2:8085/') {
//     // Subscribe to session changes
//     // client.sessionStream.listen((sessionId) {
//     //   print('We got new session ID: ${sessionId.id}');
//     // });

//     // client.loginStream.listen((event) {
//     //   if (event == OdooLoginEvent.loggedIn) {
//     //     print('Logged in');
//     //   } else if (event == OdooLoginEvent.loggedOut) {
//     //     print('Logged out');
//     //   }
//     // });

//     client.inRequestStream.listen((event) {
//       if (event) {
//         print('Request is executing');
//       } else {
//         print('Request is finished');
//       }
//     });
//   }

//   Future<void> authenticate(String dbName, String login, String password) async {
//     if(dbName.isEmpty|| login.isEmpty  || password.isEmpty ){
//         print("campos vacios") ;
//         return;
//       }
    
//     try {
//         print(client);
//       print(dbName);
//       print(login);
//       print(password);
//       final session2 = await client.authenticate('colegio_Odoo', 'carlitos@gmail.com', '123456');


// //      session = await client.authenticate('colegio_Odoo', 'carlitos@gmail.com', '123456');
//       print(session2);
//       print('Authenticated');
//     } on OdooException catch (e) {
//       print('1: $e');
//       throw e;
//     }
//   }

//   Future<void> getUserInfo() async {
//     try {
//       final uid = session.userId;
//       final res = await client.callKw({
//         'model': 'res.users',
//         'method': 'search_read',
//         'args': [],
//         'kwargs': {
//           'context': {'bin_size': true},
//           'domain': [
//             ['id', '=', uid]
//           ],
//           'fields': ['id', 'name', '__last_update', 'image_128'],
//         },
//       });
//       print('User info: $res');
//     } on OdooException catch (e) {
//       print(e);
//       throw e;
//     }
//   }

//   Future<void> createPartner(String name) async {
//     try {
//       final partnerId = await client.callKw({
//         'model': 'res.partner',
//         'method': 'create',
//         'args': [
//           {
//             'name': name,
//           },
//         ],
//         'kwargs': {},
//       });
//       print('Created partner with id: $partnerId');
//     } on OdooException catch (e) {
//       print(e);
//       throw e;
//     }
//   }

//   Future<void> getInstalledModules() async {
//     try {
//       final res = await client.callRPC('/web/session/modules', 'call', {});
//       print('Installed modules: $res');
//     } on OdooException catch (e) {
//       print(e);
//       throw e;
//     }
//   }

//   Future<void> checkSession() async {
//     try {
//       final res = await client.checkSession();
//       print('Session check: $res');
//     } on OdooSessionExpiredException {
//       print('Odoo Exception: Session expired');
//     }
//   }

//   Future<void> logout() async {
//     try {
//       await client.destroySession();
//       print('Logged out');
//     } on OdooException catch (e) {
//       print(e);
//       throw e;
//     }
//   }
// }
