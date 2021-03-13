import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('iQueChumbei'),
      ),
      body: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                      'Bem vindo à iQueChumbei',
                      style: TextStyle(
                          fontSize: 30
                      ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
    );
  }
}