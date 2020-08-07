


import 'package:http/http.dart';
import 'package:http_interceptor/http_client_with_interceptor.dart';

import 'interceptors/logging_interceptor.dart';


final Client client = HttpClientWithInterceptor.build(
  interceptors: [LoggingInterceptor()],
  requestTimeout: Duration(seconds: 5),   //o twmpo que vao durar as requisicoes
); //criando um client atraves de uma lib que intercepta as minhas requisicoes

const String baseUrl = 'http://192.168.2.88:8080/transactions';

