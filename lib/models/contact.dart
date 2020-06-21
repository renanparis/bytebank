class Contact {

  final int id;
  final String name;
  final int account;

  Contact(this.id, this.name, this.account);

  @override
  String toString() {
    return 'Contact{id: $id, name: $name, account: $account}';
  }

  Contact.fromJson(Map<String, dynamic> json) :
      id = json['id'],
      name = json['name'],
      account = json['accountNumber'];

  Map<String, dynamic> toJson() =>
      {
        'name': name,
        'accountNumber': account,
      };

}