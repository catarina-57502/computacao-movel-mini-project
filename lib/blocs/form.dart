import "dart:async";
import 'package:mini_projeto/data/datasource.dart';
import 'package:rxdart/rxdart.dart';

class Formulario {

  String _content;

  StreamController _controller = BehaviorSubject();

  Sink get _input => _controller.sink;

  Stream get output => _controller.stream;

  void onReceive(incidente){
    print("vou enviar");
    _content = _content == null ? incidente : incidente;
    _input.add(_content);
    DataSource.getInstance().insert(_content);
    print(DataSource.getInstance().getAll());
  }

  void dispose() => _controller.close();

}