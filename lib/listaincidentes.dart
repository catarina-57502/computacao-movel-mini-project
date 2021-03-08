import 'package:flutter/material.dart';

import 'formulario.dart';
import 'incidentedetalhe.dart';

class ListaIncidentesScreen extends StatelessWidget {

  final content;

  ListaIncidentesScreen(this.content);

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Lista de Incidentes'),
          bottom: new TabBar(
            tabs: <Widget>[
              new Tab(
                text: "Incidentes Abertos",
              ),
              new Tab(
                text: "Incidentes Fechados",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Container(
              margin: const EdgeInsets.all(20.0),
              child: Column(
                  children: <Widget>[
                    ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: content.length,
                        itemBuilder: (context, index){
                          final item = content[index];
                          return Dismissible(
                              key: Key(item),
                              onDismissed: (direction) {
                                print("resolvido");
                              },
                              background: Container(color: Colors.grey),
                              child: Card(
                                child: ListTile(
                                      leading: Icon(
                                      Icons.report_problem_outlined,
                                      color: Colors.red,
                                    ),
                                    title: RichText(
                                      text: TextSpan(
                                        text: titulo(content[index].toString()),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors.black,
                                        ),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: data(content[index].toString()),
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 15,
                                              )
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => DetalheScreen(content[index].toString()),
                                          ));
                                    }
                                ),
                              )


                          );
                        }
                    ),
                    SizedBox(height: 25),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: FloatingActionButton(
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => FormularioScreen()),
                          );
                        },
                        tooltip: 'Adiciona Incidente',
                        child: Icon(Icons.add),
                      ),

                    ),
                  ]
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0, top: 20.0),
              child: Align(
                  alignment: Alignment.center,
                  child: Text(
                      'incidentes fechados'
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
  String titulo(String incidente){
    var arr = incidente.split("|");

    return arr[0] + "\n";
  }

  String data(String incidente){
    var arr = incidente.split("|");

    return arr[arr.length-2];
  }

  bool isAberto(String incidente){
    var arr = incidente.split("|");
    if(arr[arr.length-1]=='Aberto'){
      return true;
    }else{
      return false;
    }
  }

}