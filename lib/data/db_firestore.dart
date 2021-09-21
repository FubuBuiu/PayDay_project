import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:nlw_project/models/boleto_model.dart';

class DBFirestore {
  DBFirestore._();
  static final DBFirestore _instance = DBFirestore._();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static get() {
    return DBFirestore._instance._firestore;
  }
}
