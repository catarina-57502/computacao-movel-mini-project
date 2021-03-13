import 'package:flutter/material.dart';
import 'package:mini_projeto/edita.dart';
import 'package:mini_projeto/home.dart';
import 'package:mini_projeto/listaincidentes.dart';
import 'package:mini_projeto/main.dart';

import 'blocs/list.dart';

class DetalheScreen extends StatelessWidget {

  final lista = Lista();

  String incidente;
  int index;


  DetalheScreen(this.incidente, this.index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detalhe de Incidente',
        ),
      ),
      body: new LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: Container(
                  margin: const EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget> [
                      Card(
                        child: Column(
                          children: <Widget>[
                            Container(
                                height: 80.0,
                                child: Center(
                                  child: Text(
                                    titulo(incidente),
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                            ),
                            Divider(),
                            ListTile(
                              title: Text(
                                'Descrição',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              subtitle: Text(
                                descricao(incidente),
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Divider(),
                            ListTile(
                              title: Text(
                                'Morada',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              subtitle: Text(
                                morada(incidente),
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Divider(),
                            ListTile(
                              title: Text(
                                'Data de Registo',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              subtitle: Text(
                                data(incidente),
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Divider(),
                            ListTile(
                              title: Text(
                                'Estado',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              subtitle: Text(
                                estado(incidente),
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      estado(incidente) == 'Aberto'
                      ? Row(
                        children: [
                         FloatingActionButton(
                           heroTag: "btn1",
                              onPressed: (){
                             showAlertDialog(context);
                              },
                           tooltip: 'Elimina Incidente',
                           child: Icon(Icons.delete),
                            ),
                          SizedBox(width: 258),
                         FloatingActionButton(
                           heroTag: "btn2",
                              onPressed: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditarScreen(incidente, index),
                                    ));
                              },
                           tooltip: 'Edita Incidente',
                           child: Icon(Icons.edit),
                            ),
                        ],
                      ) : Text(
                        ""
                      )
                    ],
                  ),
                ),
              ),
          );
        },
      ),
    );
  }

  Widget isFechado(incidente){
    if(estado(incidente)=='Aberto'){

    }
  }

  String titulo(String incidente){
    var arr = incidente.split("|");

    return arr[0];
  }

  String descricao(String incidente){
    var arr = incidente.split("|");

    return arr[1];
  }

  String morada(String incidente){
    var arr = incidente.split("|");

    if(arr[arr.length-3].isEmpty){
      return "N/A";
    }
    return arr[2];
  }

  String data(String incidente){
    var arr = incidente.split("|");

    return arr[arr.length-2];
  }

  String estado(String incidente){
    var arr = incidente.split("|");

    return arr[arr.length-1];
  }

  void showAlertDialog(BuildContext context) {

    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancelar"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = RaisedButton(
      child: Text("Eliminar"),
      color: Colors.red,
      onPressed:  () {
        lista.elimina(index);
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
            AppScreen()), (Route<dynamic> route) => false);
      },
    );


    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Elimnar"),
      content: Text("Tem a certeza que pretende eliminar este incidente?"),
      actions: [
      cancelButton,
      continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}