


import 'package:http/http.dart';

void findALl() async{
 final Response response = await  get('http://localhost:8080/transactions');
 print(response.body);
}



