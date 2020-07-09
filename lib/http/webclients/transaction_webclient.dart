import 'dart:convert';

import 'package:http/http.dart';
import 'package:paris/models/transaction.dart';

import '../webclient.dart';

class TransactionWebclient {
  Future<List<Transaction>> findAll() async {
    final Response response =
        await client.get(baseUrl);

    List<dynamic> transactionsDecode = jsonDecode(response.body);

    return transactionsDecode
        .map((dynamic json) => Transaction.fromJson(json))
        .toList();
  }

  Future<Transaction> save(Transaction transaction, String password) async {
    final String transactionsJson = jsonEncode(transaction.toJson());

    final Response response = await client.post(baseUrl,
        headers: {'Content-type': 'application/json', 'password': password},
        body: transactionsJson);

    if (response.statusCode == 200) {
      return Transaction.fromJson(jsonDecode(response.body));
    }
    throw HttpException(_getExceptionResponse[response.statusCode]);
  }

  static final Map<int, String> _getExceptionResponse = {
    400: "Falha 400",
    401: "Falha 401"
  };
}

class HttpException implements Exception {
  final String message;

  HttpException(this.message);
}
