
import 'package:flutter/material.dart';

import 'components/transaction_auth_dialog.dart';
import 'screens/dashboard.dart';


void main() {
  runApp(Bytebank());

//findALl().then((transactions) => print('new transactions ${transactions}'));
//  save(Transaction(200.0, Contact(0, 'Gui', 2000))).then((transaction) => print(transaction));
}


class Bytebank extends StatelessWidget{



  @override
  Widget build(BuildContext context){
    return MaterialApp(
      theme:ThemeData(
        primaryColor: Colors.green[900],
        accentColor:Colors.blueAccent[700],
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blueAccent[700],
          textTheme: ButtonTextTheme.primary,

        ),

      ),
      home :Dashboard(),

    );
  }


}

