import 'dart:convert';

import 'package:bytebank/models/transaction.dart';
import 'package:http/http.dart';

import '../webclient.dart';

class TransactionWebClient {
  Future<List<Transaction>> findALl() async {
    final Response response = await client.get(baseUrl);

//        .timeout(Duration(
//        seconds: 5)); //se nao tiver o time out vai carregar para sempre

    print(response);

    //===convertendo json para dart
    List<Transaction> transactions = _toTransactions(response);
    //=========
    return transactions;
    //============
  }

  Future<Transaction> save(Transaction transaction, String password) async {
    final String transactionJson = jsonEncode(transaction.toJson());

    final Response response = await client.post(baseUrl,
        headers: {
          'Content-type': 'application/json',
          'password': password,
        },
        body: transactionJson);

    if (response.statusCode == 200) {
      return Transaction.fromJson(jsonDecode(response.body));
    }

    throw HttpException(_statusCodeResponses[response.statusCode]);
  }



  static final Map<int, String> _statusCodeResponses = {
    400: 'there was an error submitting transaction',
    401: 'authentication failed'
  } ;

  //metodo extraido com ctrl+alt+m
  List<Transaction> _toTransactions(Response response) {
    final List<dynamic> decodedJson = jsonDecode(response.body);

    final List<Transaction> transactions = decodedJson.map((dynamic json) {
      //pega um elemento e transforma em lista
      return Transaction.fromJson(json);
    }).toList();

//    //criando uma lista de transferencias
//    final List<Transaction> transactions = List();
//    for (Map<String, dynamic> transactionJson in decodedJson) {
//
//
//      transactions.add(Transaction.fromJson(transactionJson));
//    }
    return transactions;
  }

//  Transaction _toTransaction(Response response) {
//
//
//
//   return Transaction.fromJson(jsonDecode(response.body));
//  }

//  Map<String, dynamic> _toMap(Transaction transaction) {
//       final Map<String, dynamic> transactionMap = {
//      'value': transaction.value,
//      'contact': {
//        'name': transaction.contact.name,
//        'accountNumber': transaction.contact.accountNumber
//      }
//    };
//    return transactionMap;
//  }

}

class HttpException implements Exception {
  final String message;

  HttpException(this.message);



}
