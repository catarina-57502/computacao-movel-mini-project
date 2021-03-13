import 'package:flutter/material.dart';
import 'blocs/form.dart';
import 'blocs/list.dart';
import 'formulario.dart';
import 'home.dart';
import 'listaincidentes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iQueChumbei',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: AppScreen(),
    );
  }
}

class AppScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return AppScreenState();
  }
}

class AppScreenState extends State<AppScreen> {

  int _selectedIndex = 0;
  final form = Formulario();
  final list = Lista();

  List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    FormularioScreen(),
    ListaIncidentesScreen(""),
  ];

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if(_selectedIndex==2){
      list.onReceive();
      _widgetOptions[2] = StreamBuilder(
        initialData: "0",
        stream: list.output,
        builder: (BuildContext context, snapshot) => ListaIncidentesScreen(
            snapshot.data
        ),
      );

    }
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_drive_file_outlined),
            label: 'Formulário',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Lista de Incidentes',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.teal,
        onTap: onItemTapped,
      ),
    );
  }
  @override
  void dispose(){
    list.dispose();
    super.dispose();
  }
}


