import 'package:flutter/material.dart';

class DetalheScreen extends StatelessWidget {

  String incidente;

  DetalheScreen(this.incidente);

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
                      Row(
                        children: [
                         FloatingActionButton(
                           heroTag: "btn1",
                              onPressed: (){
                              },
                           tooltip: 'Elimina Incidente',
                           child: Icon(Icons.delete),
                            ),

                          SizedBox(width: 258),
                         FloatingActionButton(
                           heroTag: "btn2",
                              onPressed: (){
                              },
                           tooltip: 'Edita Incidente',
                           child: Icon(Icons.edit),
                            ),
                        ],
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

    print(arr.length);

    if(arr.length==4){
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

}