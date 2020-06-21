import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paris/components/progress.dart';
import 'package:paris/dao/contact_dao.dart';
import 'package:paris/models/contact.dart';
import 'package:paris/screens/form_contacts.dart';
import 'package:paris/screens/transaction_form.dart';

class ContactsList extends StatefulWidget {
  @override
  _ContactsListState createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  final ContactDao _dao = new ContactDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transfer'),
      ),
      body: FutureBuilder<List<Contact>>(
        initialData: List(),
        future: _dao.findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Progress();
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              List<Contact> contacts = snapshot.data;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final Contact contact = contacts[index];
                  return _ItemContact(
                    contact,
                    onClick: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => TransactionForm(contact)));
                    },
                  );
                },
                itemCount: contacts.length,
              );
              break;
          }
          return Text('Error');
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => FormContacts(),
          ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class _ItemContact extends StatelessWidget {
  final Contact _contact;
  final Function onClick;

  _ItemContact(this._contact, {@required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => onClick(),
        title: Text(
          _contact.name,
          style: TextStyle(fontSize: 24),
        ),
        subtitle: Text(
          _contact.account.toString(),
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
