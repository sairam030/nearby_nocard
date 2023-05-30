import 'package:nearby_nocard/app_exports.dart';

import '../models/user.dart';

class FirestoreService {
  static final FirestoreService _singleton = FirestoreService._internal();

  factory FirestoreService() {
    return _singleton;
  }

  FirestoreService._internal();

  // Firebase Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get a reference to a collection
  CollectionReference getCollection(String collectionName) {
    return _firestore.collection(collectionName);
  }

  // Add a new document to a collection
  Future<DocumentReference> addDocument(
      String collectionName, Map<String, dynamic> data) async {
    final CollectionReference collection = getCollection(collectionName);
    return collection.add(data);
  }

  // Update a document in a collection
  Future<void> updateDocument(String collectionName, String documentId,
      Map<String, dynamic> data) async {
    final DocumentReference document =
        getCollection(collectionName).doc(documentId);
    return document.update(data);
  }

  // Delete a document from a collection
  Future<void> deleteDocument(String collectionName, String documentId) async {
    final DocumentReference document =
        getCollection(collectionName).doc(documentId);
    return document.delete();
  }

  // Get a document from a collection
  Future<DocumentSnapshot> getDocument(
      String collectionName, String documentId) async {
    final DocumentReference document =
        getCollection(collectionName).doc(documentId);
    return document.get();
  }

  // Stream all documents from a collection
  Stream<QuerySnapshot> streamCollection(String collectionName) {
    final CollectionReference collection = getCollection(collectionName);
    return collection.snapshots();
  }

  // Get multiple documents using getAll()
  Future<List<DocumentSnapshot>> getDocuments(
      List<DocumentReference> documentRefs) async {
    final List<Future<DocumentSnapshot>> futures =
        documentRefs.map((ref) => ref.get()).toList();
    final List<DocumentSnapshot> documentSnapshots = await Future.wait(futures);
    return documentSnapshots;
  }

  Stream<bool> doesDocumentExist(String documentId) {
    return getUsersStream()
        .map((snapshot) => snapshot.docs.any((doc) => doc.id == documentId));
  }

  Stream<QuerySnapshot> getUsersStream() {
    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');
    return usersCollection.snapshots();
  }

  //fuction to get the user data from the firestore from collection users and document id is the email of the user
  Future<NoCardUsers> getUserData(String email) async {
    DocumentSnapshot documentSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(email).get();
    return NoCardUsers.fromJson(documentSnapshot.data()! as Map<String, dynamic>);
  }
}
