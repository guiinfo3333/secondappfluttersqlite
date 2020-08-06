
import 'package:bytebank/components/centered_message.dart';
import 'package:bytebank/components/progress.dart';
import 'package:bytebank/http/webclients/transaction_webclient.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionsList extends StatelessWidget {

final TransactionWebClient _webClient = TransactionWebClient();



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions'),
      ),
      body:
        FutureBuilder<List<Transaction>>(
            future:_webClient.findALl(),
            builder :(context,snapshot){

              switch(snapshot.connectionState){  //o state para o caso de dar algum erro

                case ConnectionState.none:
                  // TODO: Handle this case.
                  break;
                case ConnectionState.waiting:
                  return Progress();
                  break;
                case ConnectionState.active:
                  // TODO: Handle this case.
                  break;
                case ConnectionState.done:

                  if(snapshot.hasData){  //para o caso de nao ter dado,como usar uma url errada
                    final List<Transaction> transactions = snapshot.data;  //peganddo os dados no snapshot

                    if(transactions.isNotEmpty){
                      return  ListView.builder(

                        itemBuilder: (context, index ) {
                          final Transaction transaction = transactions[index];
                          return Card(
                            child: ListTile(
                              leading: Icon(Icons.monetization_on),
                              title: Text(
                                transaction.value.toString(),
                                style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                transaction.contact.accountNumber.toString(),
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: transactions.length,
                      );
                    }
                  }

                  return CenteredMessage('No transactions found',icon:Icons.warning,);

                  break;
              }

            return Text('Uknown error');


            },
        ),

    );
  }
}





