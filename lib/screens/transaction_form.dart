import 'dart:async';

import 'package:bytebank/components/progress.dart';
import 'package:bytebank/components/response_dialog.dart';
import 'package:bytebank/components/transaction_auth_dialog.dart';
import 'package:bytebank/http/webclients/transaction_webclient.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TransactionForm extends StatefulWidget {
  final Contact contact;

  TransactionForm(this.contact);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _valueController = TextEditingController();
  final TransactionWebClient _webClient = TransactionWebClient();
  final String  transactionId = Uuid().v4();

  bool _sending = false;  //gera o id atraves dessa biblioteca

  @override
  Widget build(BuildContext context) {
    print('transaction form id $transactionId');

    return Scaffold(
      appBar: AppBar(
        title: Text('New transaction'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Visibility(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Progress(message: 'Sending...'),
                ),
                visible:_sending,
              ),

              Text(
                widget.contact.name,
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  widget.contact.accountNumber.toString(),
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _valueController,
                  style: TextStyle(fontSize: 24.0),
                  decoration: InputDecoration(labelText: 'Value'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: RaisedButton(
                    child: Text('Transfer'),
                    onPressed: () {
                      final double value =
                          double.tryParse(_valueController.text);
                      final transactionCreated =
                          Transaction(transactionId,value, widget.contact);
                      showDialog(
                          context: context,
                          builder: (contextDialog) {
                            //chamando a tranactiondialog
                            return TransactionAuthDialog(
                              onConfirm: (String password) {
                                _save(transactionCreated, password, context);
                              },
                            );
                          });
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _save(
    Transaction transactionCreated,
    String password,
    BuildContext context,
  ) async {

    setState(() {   //antes de enviar realmente os dados ele vai  modificar o _sending;
      _sending = true;
    });
//  await Future.delayed(Duration(seconds: 1));
    Transaction transaction = await _send(
      transactionCreated,
      password,
      context,
    );

    setState(() {
      _sending = false;      //logo depois de salvar aí sim ele fecha o reload
    });
    _showSuccessfulMessage(transaction, context);
  }

  Future _showSuccessfulMessage(
      Transaction transaction, BuildContext context) async {
    if (transaction != null) {
      await showDialog(
          context: context,
          builder: (contextDialog) {
            return SuccessDialog('sucessfull transaction');
          });
      Navigator.pop(context); //para o caso de dar sucesso e depois voltar

    }
  }

  Future<Transaction> _send(Transaction transactionCreated, String password,
      BuildContext context) async {
    final Transaction transaction = await _webClient
        .save(transactionCreated, password)
        // o test é para verificar se realmente foi mandando uma exception e não quqalquer coisa mas eu posso adicionar outros caths de erro
        .catchError((e) {
      _showFailureMessage(context,message: e.message);
    }, test: (e) => e is HttpException).catchError((e) {
        _showFailureMessage(context,message: 'timeout submitting the transaction');
    }, test: (e) => e is TimeoutException).catchError((e) {
      //capturando erro generico, mas tem q deixar ele no final pq ele é muito genérico
      _showFailureMessage(context);
    }).
    whenComplete((){        //quando algo for finalizado eu executo o whenComplete

      setState(() {
        _sending = false;
      });

    });
    return transaction;
  }

  void _showFailureMessage(      //para otimizar a chamada do show dialog
    BuildContext context, {
    String message = 'Unknown error',
  }) {
    showDialog(
        context: context,
        builder: (contextDialog) {
          //chamando as telas de erros
          return FailureDialog(message);
        });
  }
}
