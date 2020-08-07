
import 'package:flutter/material.dart';

class Progress extends StatelessWidget {


  final String message;

Progress({
  this.message= 'Loading',


});


  @override
  Widget build(BuildContext context) {
    return Center(
      //para que nao tiver carregado ainda ele ficar rodando a barra de progresso
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(message,style:TextStyle(fontSize:16.0),),
          ),

        ],
      ),
    );
  }
}
