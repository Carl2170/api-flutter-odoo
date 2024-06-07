import 'package:flutter/material.dart';

class AlumnoScreen extends StatefulWidget{
    const AlumnoScreen({Key? key}) : super(key: key);

  @override
  createState() =>_AlumnoScreenState();
}

class _AlumnoScreenState extends State<AlumnoScreen>{
 
  @override
  void initState(){
    super.initState();
    _initialize() ; 
}

  void _initialize(){
    setState(() {
    });
  }
  @override 
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: const Text('Alumnos'),
      ),
     
    );
  }
}
