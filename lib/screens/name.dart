import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NameCubit extends Cubit<String>{
  NameCubit(String name) : super(name);

  void change(String name) => emit(name);  //funcoes que alteram o estado

}


class NameContainer extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create:(_) => NameCubit("Guilherme"),
        child: NameView(),

    );
  }

}

class NameView extends StatelessWidget{
  final TextEditingController _nameController =  TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Change name")),
      body:Column(
        children: [
          TextField(controller: _nameController,
          decoration: InputDecoration(labelText: "Desired name:"),
            style: TextStyle(
              fontSize: 24.0,

            ),
          ),
          Padding(padding: const EdgeInsets.only(top:8.0),
          child:SizedBox(width: double.maxFinite,
          child: RaisedButton(child: Text("Change"),
            onPressed: (){
            final name = _nameController.text;
            context.bloc<NameCubit>().change(name);
            Navigator.pop(context);
          },),
          )
          )
          
        ],
      )
    );
  }
   
}