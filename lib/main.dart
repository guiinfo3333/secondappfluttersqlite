
import 'package:bytebank/components/theme.dart';
import 'package:bytebank/screens/counter.dart';
import 'package:bytebank/screens/name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import 'screens/dashboard.dart';


void main() {
  runApp(Bytebank());
  print(Uuid().v4());

//findALl().then((transactions) => print('new transactions ${transactions}'));
//  save(Transaction(200.0, Contact(0, 'Gui', 2000))).then((transaction) => print(transaction));
}


class LogObserver extends BlocObserver{
  @override
  void onChange(Cubit cubit, Change change) {
    print("${cubit.runtimeType} >  $change");
    super.onChange(cubit, change);
  }
}

class Bytebank extends StatelessWidget{

     // Bloc.

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      theme:bytebankTheme,
      home :NameContainer(),

    );
  }


}

