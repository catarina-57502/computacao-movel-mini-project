import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('iQueChumbei'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0, top: 20.0),
          child: ImageSlideshow(
            width: double.infinity,
            height: 450,
            initialPage: 0,
            indicatorColor: Colors.blue,
            indicatorBackgroundColor: Colors.grey,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Bem vindo à iQueChumbei',
                  style: TextStyle(
                      fontSize: 30
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Reporte Incidentes',
                  style: TextStyle(
                      fontSize: 30
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Acompanhe o seu \n Desenvolvimento',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
            ],
            autoPlayInterval: 3000,
          ),
        ),
      ),
    );
  }
}