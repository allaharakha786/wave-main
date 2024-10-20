import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import '../services/firebase_service.dart';

class FirestoreUtils {
  final FirebaseFirestore _firestore = FirebaseService.firestore;
  final FirebaseAuth _auth = FirebaseService.auth;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Helper method to get a Collection reference
  CollectionReference _getCollection(String collectionName) {
    return _firestore.collection(collectionName);
  }

  String getUid() {
    final User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      return currentUser.uid; // Return the user's UID if available
    } else {
      return ""; // Return null if no user is signed in
    }
  }

  // Add or set a document with data in a given collection
  Future<void> setDocument({
    required String collectionName,
    required String docId,
    required Map<String, dynamic> data,
  }) async {
    await _getCollection(collectionName).doc(docId).set(data);
  }

  // Update fields in an existing document
  Future<void> updateDocument({
    required String collectionName,
    required String docId,
    required Map<String, dynamic> updates,
  }) async {
    await _getCollection(collectionName).doc(docId).update(updates);
  }

  // Get a document from a collection (one-time fetch)
  Future<DocumentSnapshot> getDocument({
    required String collectionName,
    required String docId,
  }) async {
    return await _getCollection(collectionName).doc(docId).get();
  }

  // Add a new document to a collection without specifying docId (Firestore auto-generates it)
  Future<void> addDocument({
    required String collectionName,
    required Map<String, dynamic> data,
  }) async {
    await _getCollection(collectionName).add(data);
  }

  // Get all documents in a collection (one-time fetch)
  Future<List<Map<String, dynamic>>> getAllDocuments({
    required String collectionName,
  }) async {
    QuerySnapshot querySnapshot = await _getCollection(collectionName).get();
    return querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }

  // ---------------- Stream methods for real-time updates ----------------

  // Get a stream of all documents in a collection (real-time updates)
  Stream<List<Map<String, dynamic>>> getAllDocumentsStream({
    required String collectionName,
  }) {
    return _getCollection(collectionName).snapshots().map(
          (querySnapshot) => querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList(),
        );
  }

  // Get a stream of a single document in a collection (real-time updates)
  Stream<Map<String, dynamic>?> getDocumentStream({
    required String collectionName,
    required String docId,
  }) {
    return _getCollection(collectionName).doc(docId).snapshots().map(
          (docSnapshot) => docSnapshot.data() as Map<String, dynamic>?,
        );
  }

  // Get a stream of documents in a collection where a field matches a specific value (real-time updates)
  Stream<List<Map<String, dynamic>>> getDocumentsWhereFieldMatchesStream({
    required String collectionName,
    required String fieldName,
    required dynamic fieldValue,
  }) {
    return _getCollection(collectionName)
        .where(fieldName, isEqualTo: fieldValue)
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList());
  }

  // ---------------- Additional utility methods ----------------

  // Add a new field to all documents in a collection
  Future<void> addFieldToAllDocuments({
    required String collectionName,
    required String fieldName,
    required dynamic fieldValue,
  }) async {
    QuerySnapshot querySnapshot = await _getCollection(collectionName).get();
    for (var doc in querySnapshot.docs) {
      await _getCollection(collectionName).doc(doc.id).update({fieldName: fieldValue});
    }
  }

  // Remove a field from all documents in a collection
  Future<void> removeFieldFromAllDocuments({
    required String collectionName,
    required String fieldName,
  }) async {
    QuerySnapshot querySnapshot = await _getCollection(collectionName).get();
    for (var doc in querySnapshot.docs) {
      await _getCollection(collectionName).doc(doc.id).update({fieldName: FieldValue.delete()});
    }
  }

  // Get the value of a specific field from a document
  Future<dynamic> getFieldValueFromDocument({
    required String collectionName,
    required String docId,
    required String fieldName,
  }) async {
    DocumentSnapshot docSnapshot = await _getCollection(collectionName).doc(docId).get();
    return docSnapshot.get(fieldName);
  }

  // Check if a field exists in a document
  Future<bool> checkFieldExists({
    required String collectionName,
    required String docId,
    required String fieldName,
  }) async {
    try {
      DocumentSnapshot docSnapshot = await _getCollection(collectionName).doc(docId).get();
      return docSnapshot.data() != null && (docSnapshot.data() as Map<String, dynamic>).containsKey(fieldName);
    } catch (e) {
      print("Error checking field existence: $e");
      return false;
    }
  }

  Future<bool> checkFieldValueInAllDocs({
    required String collectionName,
    required String fieldName,
    required dynamic fieldValue, // field value can be any type (int, string, bool, etc.)
  }) async {
    try {
      QuerySnapshot querySnapshot = await _getCollection(collectionName).get();
      bool fieldExistsInAll = true; // Assume field exists in all documents initially

      // Loop through each document in the collection
      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> docData = doc.data() as Map<String, dynamic>;

        // Check if the field exists and has the specified value
        if (!docData.containsKey(fieldName) || docData[fieldName] != fieldValue) {
          fieldExistsInAll = false; // If not, set the flag to false
          break; // No need to check further if one document fails
        }
      }

      return fieldExistsInAll; // Returns true if all docs contain the field with the specified value
    } catch (e) {
      print("Error checking field value existence in all documents: $e");
      return false; // Return false if there's an error
    }
  }

  // Get documents where a field matches a specific value (one-time fetch)
  Future<List<Map<String, dynamic>>> getDocumentsWhereFieldMatches({
    required String collectionName,
    required String fieldName,
    required dynamic fieldValue,
  }) async {
    QuerySnapshot querySnapshot = await _getCollection(collectionName).where(fieldName, isEqualTo: fieldValue).get();
    return querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }

  Future<String?> uploadFileToStorage({
    required String folderName,
    required File file,
  }) async {
    try {
      // Generate a unique file name based on the file name and folder name
      String fileName = basename(file.path);
      String filePath = "$folderName/$fileName";

      // Upload the file to Firebase Storage
      UploadTask uploadTask = _storage.ref(filePath).putFile(file);

      // Wait for the upload to complete and get the download URL
      TaskSnapshot snapshot = await uploadTask.whenComplete(() => {});
      String downloadUrl = await snapshot.ref.getDownloadURL();

      // Return the download URL
      return downloadUrl;
    } catch (e) {
      print("Error uploading file to storage: $e");
      return null; // Return null in case of an error
    }
  }

  Future<List<Map<String, dynamic>>> getDocumentsWhereFieldIn({
    required String collectionName,
    required String fieldName,
    required List<dynamic> fieldValues,
  }) async {
    if (fieldValues.isEmpty) return [];

    QuerySnapshot querySnapshot = await _getCollection(collectionName)
        .where(fieldName, whereIn: fieldValues)
        .get();

    return querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }

  Future<QuerySnapshot> queryDocuments({
    required String collectionName,
    required List<Map<String, dynamic>> where,
  }) async {
    CollectionReference collection = FirebaseFirestore.instance.collection(collectionName);
    Query query = collection;
    for (var condition in where) {
      query = query.where(condition['field'], isEqualTo: condition['isEqualTo']);
    }
    return await query.get();
  }

  Future<QuerySnapshot> getDocumentByQuery({
    required String collectionName,
    required List<Map<String, dynamic>> whereConditions,
  }) async {
    try {
      CollectionReference collection = _firestore.collection(collectionName);
      Query query = collection;

      // Apply all conditions to the query
      for (var condition in whereConditions) {
        query = query.where(
          condition['field'],
          isEqualTo: condition['isEqualTo'],
        );
      }

      // Execute the query
      return await query.get();
    } catch (e) {
      print('Error fetching documents by query: $e');
      rethrow;
    }
  }
}
