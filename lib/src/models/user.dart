import 'package:cloud_firestore/cloud_firestore.dart';

class NoCardUsers {
  String name;
  String email;
  int number;
  GeoPoint location;
  String address;
  String uid;
  String imageUrl;
  List<DocumentReference> contacts;

  NoCardUsers({
    this.name = '',
    required this.email,
    this.number = 0,
    this.location= const GeoPoint(0, 0),
    this.address = '',
    required this.uid,
    this.imageUrl = 'https://www.clipartmax.com/png/middle/296-2969961_no-image-user-profile-icon.png',
    this.contacts = const [],
  });

  factory NoCardUsers.fromJson(Map<String, dynamic> json) {
    return NoCardUsers(
      name: json['name'] ?? '',
      email: json['email'],
      number: json['number'] ?? 0,
      location: json['location'],
      address: json['address'] ?? '',
      uid: json['uid'],
      imageUrl: json['imageUrl'] ?? 'https://www.clipartmax.com/png/middle/296-2969961_no-image-user-profile-icon.png',
      contacts: List<DocumentReference>.from(json['contacts']?.map((c) => FirebaseFirestore.instance.doc(c))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'number': number,
      'location': location,
      'address': address,
      'uid': uid,
      'imageUrl': imageUrl,
      'contacts': contacts.map((c) => c.path).toList(),
    };
  }

  factory NoCardUsers.updateFirestoreDocument({
    required NoCardUsers user,
    String? name,
    int? number,
    GeoPoint? location= const GeoPoint(0, 0),
    String? address,
    String? imageUrl,
    List<DocumentReference>? contacts,
  }) {
    return NoCardUsers(
      name: name ?? user.name,
      email: user.email,
      number: number ?? user.number,
      location: location ?? user.location,
      address: address ?? user.address,
      uid: user.uid,
      imageUrl: imageUrl ?? user.imageUrl,
      contacts: contacts ?? user.contacts,
    );
  }
}
