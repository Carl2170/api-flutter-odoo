// class Alumno {
//   final int id;
//   final String nombre;
//   final String apellidoPaterno;
//   final String apellidoMaterno;
//   final String fechaNacimiento;
//   final String direccion;
//   final int edad;
//   final List<dynamic> apoderado;
//   final List<dynamic> mensualidades;
//   final List<dynamic> cursos;
//   final List<dynamic> cursosMaterias;
//   final String nombreCompleto;
//   final String displayName;
//   final List<dynamic> createUid;
//   final String createDate;
//   final List<dynamic> writeUid;
//   final String writeDate;

//   Alumno({
//     required this.id,
//     required this.nombre,
//     required this.apellidoPaterno,
//     required this.apellidoMaterno,
//     required this.fechaNacimiento,
//     required this.direccion,
//     required this.edad,
//     required this.apoderado,
//     required this.mensualidades,
//     required this.cursos,
//     required this.cursosMaterias,
//     required this.nombreCompleto,
//     required this.displayName,
//     required this.createUid,
//     required this.createDate,
//     required this.writeUid,
//     required this.writeDate,
//   });

//   factory Alumno.fromJson(Map<String, dynamic> json) {
//     return Alumno(
//       id: json['id'],
//       nombre: json['nombre'],
//       apellidoPaterno: json['apellido_paterno'],
//       apellidoMaterno: json['apellido_materno'],
//       fechaNacimiento: json['fecha_nacimiento'],
//       direccion: json['direccion'],
//       edad: json['edad'],
//       apoderado: json['apoderado'],
//       mensualidades: json['mensualidades'],
//       cursos: json['cursos'],
//       cursosMaterias: json['cursos_materias'],
//       nombreCompleto: json['nombre_completo'],
//       displayName: json['display_name'],
//       createUid: json['create_uid'],
//       createDate: json['create_date'],
//       writeUid: json['write_uid'],
//       writeDate: json['write_date'],
//     );
//   }
// }
