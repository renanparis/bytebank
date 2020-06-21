import 'package:paris/database/bytebank_db.dart';
import 'package:paris/models/contact.dart';
import 'package:sqflite/sqflite.dart';

class ContactDao {

  static const String sqlTable = 'CREATE TABLE $_nameTable('
      '$_id INTEGER PRIMARY KEY,'
      '$_name TEXT,'
      '$_accountNumber INTEGER)';

  static const String _nameTable = 'contacts';
  static const String _id = 'id';
  static const String _name = 'name';
  static const String _accountNumber = 'account_number';


  Future<int> save(Contact contact) async {
    final Database db = await getDatabase();
    Map<String, dynamic> contactMap = _toMap(contact);
    return db.insert(_nameTable, contactMap);
  }

  Map<String, dynamic> _toMap(Contact contact) {
    final Map<String, dynamic> contactMap = new Map();
    contactMap[_name] = contact.name;
    contactMap[_accountNumber] = contact.account;
    return contactMap;
  }

  Future<List<Contact>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_nameTable);
    List<Contact> contacts = _toList(result);
    return contacts;
  }

  List<Contact> _toList(List<Map<String, dynamic>> result) {
    final List<Contact> contacts = new List();
    for (Map<String, dynamic> map in result) {
      final Contact contact = new Contact(
          map[_id],
          map[_name],
          map[_accountNumber]);
      contacts.add(contact);
    }
    return contacts;
  }


}