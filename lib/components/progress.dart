import 'package:flutter/material.dart';

class Progress extends StatelessWidget {

  final String title;
  Progress({this.title = 'Loading'});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(title, style: TextStyle(fontSize: 16),),
          )
        ],
      ),
    );
  }
}
