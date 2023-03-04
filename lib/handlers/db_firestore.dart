import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ToDoFirestore {
  final auth = FirebaseAuth.instance;

  Future addTask(String collection, Map<String, dynamic> data) async {
    await FirebaseFirestore.instance.collection(collection).doc().set(data);
  }
}
