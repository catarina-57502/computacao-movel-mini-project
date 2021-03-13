import 'package:flutter/material.dart';
import 'package:mini_projeto/data/datasource.dart';
import 'package:queries/collections.dart';
import 'blocs/list.dart';
import 'formulario.dart';
import 'incidentedetalhe.dart';
import 'dart:math';

var incidentesFechados = List();

class ListaIncidentesScreen extends StatefulWidget {

  var content;

  ListaIncidentesScreen(this.content);

  @override
  State<StatefulWidget> createState(){
    return _ListaIncidentesScreenState();
  }

}


class _ListaIncidentesScreenState extends State<ListaIncidentesScreen> {

  final _random = new Random();

  final list = Lista();

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
              child: GestureDetector(
                  onLongPress: () {
                    if(widget.content.toString().contains('Aberto')){
                      WidgetsBinding.instance.addPostFrameCallback((_){
                        setState(() {
                          list.resolve(_random.nextInt(widget.content.length));
                        });
                      });
                    }
                  },
                child: Stack(
                    children: <Widget>[
                      widget.content.toString().length > 1
                          ? ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount:  widget.content.length,
                        itemBuilder: (context, index){
                          if(!isFechado( widget.content[index])){
                            final item =  widget.content[index];
                            return Dismissible(
                                key: Key(item),
                                confirmDismiss: (direction) => podeFechar(item),
                                onDismissed: (direction) {
                                    WidgetsBinding.instance.addPostFrameCallback((_){
                                      setState(() {
                                        list.fecha(index);
                                      });
                                      Scaffold.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('O seu incidente foi dado como fechado.'),
                                        ),
                                      );
                                    });
                                },
                                background: Container(color: Colors.grey),
                                child: Card(
                                  child: ListTile(
                                      leading: isResolvidoIcon(item),
                                      title: RichText(
                                        text: TextSpan(
                                          text: titulo( widget.content[index].toString()),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.black,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: data( widget.content[index].toString()),
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
                                              builder: (context) => DetalheScreen( widget.content[index].toString(), index),
                                            ));
                                      },
                                  ),
                                )
                            );
                          }else{
                            WidgetsBinding.instance.addPostFrameCallback((_){
                              setState(() {
                                incidentesFechados.add(widget.content[index]);
                                incidentesFechados = Collection(incidentesFechados).distinct().toList();
                              });
                            });

                          }
                          return null;
                        },
                      ) : Center(
                          child: Text(
                            'Sem incidentes para mostrar',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          )
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
                )

              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0, top: 20.0),
              child: Stack(
                children: <Widget>[
                  incidentesFechados.length > 0
                      ? ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: incidentesFechados.length,
                      itemBuilder: (context, index){
                        return Card(
                          child: ListTile(
                              title: RichText(
                                text: TextSpan(
                                  text: titulo(incidentesFechados[index].toString()),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: data(incidentesFechados[index].toString()),
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
                                      builder: (context) => DetalheScreen(incidentesFechados[index].toString(), index),
                                    ));
                              }
                          ),
                        );
                      }
                  ) : Center(
                      child: Text(
                        'Não existem incidentes fechados',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      )
                  ),
                ],
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

  bool isFechado(String incidente){
    var arr = incidente.split("|");
    if(arr[arr.length-1]=='Fechado'){
      return true;
    }else{
      return false;
    }
  }

  bool isResolvido(String incidente){
    var arr = incidente.split("|");
    print(arr[arr.length-1]);
    if(arr[arr.length-1]=='Resolvido'){
      return true;
    }else{
      return false;
    }
  }

  Widget isResolvidoIcon(String incidente){
    var arr = incidente.split("|");
    if(arr[arr.length-1]=='Aberto'){
      return Icon(
        Icons.report_problem_outlined,
        color: Colors.red,
      );
    }
    return Icon(
      Icons.check_circle_outline,
      color: Colors.green,
    );
  }

  Future<bool> podeFechar(incidente) async {
    if(isResolvido(incidente)){
      return true;
    }

    Scaffold.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Este incidente ainda não se encontra resolvido, por isso não pode transitar para a lista dos fechados.'),
                                      ),
                                    );
    return false;
  }

}