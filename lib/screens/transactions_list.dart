import 'package:flutter/material.dart';
import 'package:paris/components/centered_message.dart';
import 'package:paris/components/progress.dart';
import 'package:paris/http/webclients/transaction_webclient.dart';
import 'package:paris/models/transaction.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> transactions = List();
  final TransactionWebclient _webclient = TransactionWebclient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions'),
      ),
      body: FutureBuilder<List<Transaction>>(
        future: Future.delayed(Duration(seconds: 1)).then((value) => _webclient.findAll()),
        builder: (context, snapshot) {
          List<Transaction> transactions = snapshot.data;

          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Progress();
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if (snapshot.hasData) {
                if (transactions.isNotEmpty) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
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
                            transaction.contact.account.toString(),
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
              return CenteredMessage(
                'No Transactions Found',
                icon: Icons.warning,
              );

              break;
          }
          return CenteredMessage('Unknow Error');
        },
      ),
    );
  }
}
