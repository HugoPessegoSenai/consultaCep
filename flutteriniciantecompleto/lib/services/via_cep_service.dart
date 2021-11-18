import 'package:flutter/cupertino.dart';
import 'package:flutteriniciantecompleto/models/result_cep.dart';
import 'package:http/http.dart' as http;

class ViaCepService {
  static Future<ResultCep> ReqCep({required String cep}) async {
    var client = http.Client();
    try {
      final response =
          await client.get(Uri.parse('https://viacep.com.br/ws/$cep/json/'));
      if (response.statusCode == 200) {
        return ResultCep.fromJson(response.body);
      } else {
        debugPrint('Requisição invalida');
        throw Exception('Requisição invalida');
      }
    } finally {
      client.close();
    }
  }
}
