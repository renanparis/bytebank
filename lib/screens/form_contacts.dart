import 'package:flutter/material.dart';
import 'package:paris/dao/contact_dao.dart';
import 'package:paris/models/contact.dart';

class FormContacts extends StatefulWidget {
  @override
  _FormContactsState createState() => _FormContactsState();
}

class _FormContactsState extends State<FormContacts> {
  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _accountNumber = new TextEditingController();
  final ContactDao _dao = new ContactDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Full name',
              ),
              style: TextStyle(fontSize: 24),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextField(
                controller: _accountNumber,
                decoration: InputDecoration(
                  labelText: 'Number Account',
                ),
                style: TextStyle(fontSize: 24),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: SizedBox(
                width: double.maxFinite,
                child: RaisedButton(
                  child: Text('Create'),
                  onPressed: () {
                    final String name = _nameController.text;
                    final int account = int.tryParse(_accountNumber.text);
                    final Contact newContact = new Contact(0, name, account);
                    _dao.save(newContact).then((id) => Navigator.pop(context));
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
