import 'dart:convert';

import 'package:http/http.dart';
import 'package:paris/models/transaction.dart';

import '../webclient.dart';

class TransactionWebclient {
  Future<List<Transaction>> findAll() async {
    final Response response =
        await client.get(baseUrl).timeout(Duration(seconds: 5));

    List<dynamic> transactionsDecode = jsonDecode(response.body);

    return transactionsDecode
        .map((dynamic json) => Transaction.fromJson(json))
        .toList();
  }

  Future<Transaction> save(Transaction transaction) async {
    final String transactionsJson = jsonEncode(transaction.toJson());

    final Response response = await client.post(baseUrl,
        headers: {'Content-type': 'application/json', 'password': '1000'},
        body: transactionsJson);
    return Transaction.fromJson(jsonDecode(response.body));
  }
}
