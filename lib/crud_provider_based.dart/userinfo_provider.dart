import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'user.dart';


class UserProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<User> _users = [];

  List<User> get users => _users;

  Future<void> fetchUsers() async {
    try {
      final querySnapshot = await _firestore.collection('students').get();
      _users = querySnapshot.docs.map((doc) {
        return User(
          id: doc.id,
          name: doc['name'],
          email: doc['email'],
        );
      }).toList();
      notifyListeners();
    } catch (e) {
      print("Error fetching users: $e");
    }
  }


  // Add other CRUD operations here (create, update, delete)
}
