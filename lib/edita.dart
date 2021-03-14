import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'blocs/form.dart';
import 'blocs/list.dart';
import 'incidente.dart';
import 'main.dart';


class EditarScreen extends StatelessWidget {

  final form = Formulario();

  final _formKey = GlobalKey<FormState>();
  Incidente _incidente = Incidente();

  String incidente;
  final lista = Lista();
  int index;

  EditarScreen(this.incidente, this.index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar'),
      ),
      body: new LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: Column(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.all(24),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    'Título',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  contentPadding: new EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0)
                                  ),
                                  prefixIcon: Icon(
                                    Icons.title,
                                    color: Colors.teal,
                                  ),
                                ),
                                initialValue: titulo(incidente),
                                maxLength: 25,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Campo Obrigatório';
                                  }else if(value.length>25){
                                    return 'Ultrapassou o máximo de 25 caracteres premitidos';
                                  }
                                  return null;
                                },
                                onSaved: (value) => _incidente.titulo = value,
                              ),
                              SizedBox(height: 5),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    'Descrição',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  contentPadding: new EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0)
                                  ),
                                  prefixIcon: Padding(
                                      padding: new EdgeInsets.only(bottom: 65),
                                      child: Icon(
                                        Icons.description,
                                        color: Colors.teal,
                                      )
                                  ),
                                ),
                                initialValue: descricao(incidente),
                                maxLength: 200,
                                maxLines: null,
                                minLines: 4,
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Campo Obrigatório';
                                  }else if(value.length<100){
                                    return 'Descrição tem de ter um mínimo de 100 caracteres';
                                  }else if(value.length>200){
                                    return 'Ultrapassou o máximo de 200 caracteres premitidos';
                                  }
                                  return null;
                                },
                                onSaved: (value) => _incidente.descricao = value,
                              ),
                              SizedBox(height: 5),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    'Morada (Opcional)',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                keyboardType: TextInputType.streetAddress,
                                decoration: InputDecoration(
                                  contentPadding: new EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0)
                                  ),
                                  prefixIcon: Icon(
                                    Icons.house,
                                    color: Colors.teal,
                                  ),
                                ),
                                initialValue: morada(incidente),
                                maxLength: 60,
                                validator: (String value) {
                                  if (value.length>60) {
                                    return 'Ultrapassou o máximo de 60 caracteres premitidos';
                                  }
                                  return null;
                                },
                                onSaved: (value) => _incidente.morada = value,
                              ),
                              SizedBox(height: 20),
                              ButtonTheme(
                                minWidth: 380.0,
                                height: 55.0,
                                child: RaisedButton(
                                  child: Text(
                                    'Editar',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20
                                    ),
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      _incidente.dataHora = formata(DateTime.now());
                                      _formKey.currentState.save();
                                      showAlertDialog(context);
                                    }
                                    //form.onReceive(_incidente.toString());
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]
                ),
              ),
            );
          }
      ),
    );
  }
  String formata(data){
    final DateFormat formatter = DateFormat('dd/MM/yyyy H:m:s');
    return formatter.format(data);
  }

  void showAlertDialog(BuildContext context) {

    Widget cancelButton = FlatButton(
      child: Text("Cancelar"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = RaisedButton(
      child: Text("Editar"),
      color: Colors.green,
      onPressed:  () {
        lista.elimina(index);
        form.onReceive(_incidente.toString());
        showAlertDialog2(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Editar Incidente"),
      content: Text("Tem a certeza que pretende editar este incidente?"),
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
    return "";
  }
  return arr[2];
}

void showAlertDialog2(BuildContext context) {

  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
          AppScreen()), (Route<dynamic> route) => false);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Editar Incidente"),
    content: Text("O seu incidente foi editado com sucesso."),
    actions: [
      okButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}