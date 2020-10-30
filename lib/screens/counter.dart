import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//gerencia o estato tipo int
class CounterCubit extends Cubit<int>{
  CounterCubit() : super(0);
  void incremet()=>emit(state+1);
  void decrecremet()=>emit(state-1);


}


//aqui e onde a gente vai criar o nosso contador e vai prover o contador para quem precisar
class CounterContainer extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   //bloc_provider junta um cubit que é um estado com o counterview que é uma view
    return BlocProvider(
      create: (_)=> CounterCubit(),
      child: CounterConntext(),
    );
  }

}

class CounterConntext extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final  textTheme =  Theme.of(context).textTheme;
        return Scaffold(
          appBar: AppBar(title: const Text("Nosso contador")),
          body:Center(
            //bloc builder cria um widget baseado no bloc
            child: BlocBuilder<CounterCubit,int>(
                builder:(context,state){
                  return Text("$state",style: textTheme.headline2);
                }
            ),
          ),floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            FloatingActionButton(child: const Icon(Icons.add),
              //abordagem um de como acessar o bloc
              onPressed: ()=>context.bloc<CounterCubit>().incremet(),),
            SizedBox(height: 8,),
            FloatingActionButton(child: const Icon(Icons.remove ),

              onPressed: ()=>context.bloc<CounterCubit>().decrecremet(),)

          ],
        ),
        );
  }

}