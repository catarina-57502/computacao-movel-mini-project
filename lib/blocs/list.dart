import "dart:async";
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

  void dispose() => _controller.close();

}