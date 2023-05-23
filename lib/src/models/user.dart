import 'package:nearby_nocard/app_exports.dart';

class User {
  final String name;
  final String address;
  final String mail;
  final String number1;
  final String number2;
  final String role;
  final List<DocumentReference> contacts;

  User({
    required this.name,
    required this.address,
    required this.mail,
    required this.number1,
    required this.number2,
    required this.role,
    required this.contacts,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    List<DocumentReference> contacts = [];
    if (json['contacts'] != null) {
      for (var item in json['contacts']) {
        contacts.add(item);
      }
    }
    return User(
      name: json['name'],
      address: json['address'],
      mail: json['mail'],
      number1: json['number1'],
      number2: json['number2'],
      role: json['role'],
      contacts: contacts,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['address'] = address;
    data['mail'] = mail;
    data['number1'] = number1;
    data['number2'] = number2;
    data['role'] = role;
    data['contacts'] = contacts;
    return data;
  }

  @override
  String toString() {
    return 'User{name: $name, address: $address, mail: $mail, number1: $number1, number2: $number2, role: $role, contacts: $contacts}';
  }

  User copyWith({
    String? name,
    String? address,
    String? mail,
    String? number1,
    String? number2,
    String? role,
    List<DocumentReference>? contacts,
  }) {
    return User(
      name: name ?? this.name,
      address: address ?? this.address,
      mail: mail ?? this.mail,
      number1: number1 ?? this.number1,
      number2: number2 ?? this.number2,
      role: role ?? this.role,
      contacts: contacts ?? this.contacts,
    );
  }
}
