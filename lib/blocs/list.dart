import "dart:async";
import 'package:flutter/cupertino.dart';
import 'package:mini_projeto/data/datasource.dart';
import 'package:rxdart/rxdart.dart';

class Lista {

  StreamController _controller = BehaviorSubject();

  Sink get _input => _controller.sink;

  Stream get output => _controller.stream;

  void onReceive(){
    print("recebi");
    print(DataSource.getInstance().getAll());
    _input.add(DataSource.getInstance().getAll());
  }

  void insert(content){
    DataSource.getInstance().insert(content);
    _input.add(DataSource.getInstance().getAll());
  }

  void resolve(index){
    String content = DataSource.getInstance().getAll()[index].toString();

    if(content[content.length-6]=='A'){
      if (content != null && content.length > 0) {

        content = content.substring(0, content.length - 6);
      }

      content += 'Resolvido';

      print(content);

      DataSource.getInstance().remove(DataSource.getInstance().getAll()[index]);
      DataSource.getInstance().insert(content);
    }

    _input.add(DataSource.getInstance().getAll());

  }

  void fecha(index){
    String content = DataSource.getInstance().getAll()[index].toString();

    if (content != null && content.length > 0) {
      content = content.substring(0, content.length - 9);
    }

    content += 'Fechado';

    print(content);

    DataSource.getInstance().remove(DataSource.getInstance().getAll()[index]);
    DataSource.getInstance().insert(content);

    _input.add(DataSource.getInstance().getAll());

  }

  void elimina(index){
    DataSource.getInstance().remove(DataSource.getInstance().getAll()[index]);
    _input.add(DataSource.getInstance().getAll());
  }

  void dispose() => _controller.close();

}