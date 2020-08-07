import 'package:flutter/material.dart';

class TransactionAuthDialog extends StatefulWidget {
  final Function(String password) onConfirm;

  TransactionAuthDialog({
    @required this.onConfirm,
  });

  @override
  _TransactionAuthDialogState createState() => _TransactionAuthDialogState();
}

class _TransactionAuthDialogState extends State<TransactionAuthDialog> {
  //criando controlador

  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Authenticate'),
      content: TextField(
          controller: _passwordController,
          obscureText: true,
          //para ser senha
          maxLength: 4,
          decoration:
              InputDecoration(border: OutlineInputBorder() //coloca a borda
                  ),
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          //so number
          style: TextStyle(fontSize: 64, letterSpacing: 24)),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel')),
        FlatButton(
            onPressed: () {
              widget.onConfirm(_passwordController.text);
              Navigator.pop(
                  context); //tira a tela que esta acima da pilha de telas, no caso a tela de dailog
            },
            child: Text('Confirm'))
      ],
    );
  }
}
