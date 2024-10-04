import 'package:cloud_firestore/cloud_firestore.dart';

class FirestorePaths {
  final FirebaseFirestore _firestore;
  FirestorePaths(this._firestore);
  CollectionReference get usersCollection => _firestore.collection('users');

  DocumentReference userDocument(String userID) => usersCollection.doc(userID);

  CollectionReference categoriesCollection(String userID) =>
      userDocument(userID).collection('CATEGORIES');

  DocumentReference categoryDocument(String userID, String categoryID) =>
      categoriesCollection(userID).doc(categoryID);

  CollectionReference todosCollection(String userID, String categoryID) =>
      categoryDocument(userID, categoryID).collection('TODOS');

  DocumentReference todoDocument(
          String userID, String categoryID, String todoID) =>
      todosCollection(userID, categoryID).doc(todoID);
}
