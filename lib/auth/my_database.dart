import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_money_track/auth/authentication.dart';

class MyDatabase {
  final db = FirebaseFirestore.instance;
  User? currentUser = Authentication().currentUser;

  Future<void> addNewUserToDb(UserCredential? userCredential, String username) async {
    if (userCredential != null && userCredential.user != null){
      await
      db
          .collection("users")
          .doc(userCredential.user!.email)
          .set({
        "email": userCredential.user!.email,
        "username": username,
      });
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUsername() async {
    return await
    db
        .collection("users")
        .doc(currentUser!.email)
        .get();
  }

  Stream<DocumentSnapshot> getStreamData(String collectionName) {
    return
      db
          .collection(collectionName)
          .doc(currentUser!.email)
          .snapshots();
  }

  Future<void> addTransactionToDb(
      String title,
      String description,
      double amount,
      String transactionType,
      String transactionCategory
      )
  async {
    final transactionData = {
      'Title': title,
      'Description': description,
      'Amount': amount,
      'transactionType': transactionType,
      'transactionCategory': transactionCategory,
      'Date': DateTime.now(),
    };

    final usersCollectionRef = db.collection('users');
    final userTransactionDocRef = usersCollectionRef.doc(currentUser!.email);

    final newTransactionRef = userTransactionDocRef.collection('user_transactions').doc(); // Assuming 'user_transactions' as sub-collection

    await newTransactionRef.set(transactionData);
  }

  Stream<QuerySnapshot> getTransactionStream() {
     return
       db
         .collection("users")
         .doc(currentUser!.email)
         .collection("user_transactions")
         .orderBy("Date", descending: true)
         .snapshots();
  }

  Future<QuerySnapshot> getSumAmount() {
    return
      db
        .collection("users")
        .doc(currentUser!.email)
        .collection("user_transactions")
        .get();
  }

  Future<void> addBillsToDb(
      String title,
      String description,
      double amount,
      DateTime dueDate,
      )
  async {
    final billsData = {
      'Title': title,
      'Description': description,
      'Amount': amount,
      'dueDate': dueDate,
      'isFinished': false,
    };

    final usersCollectionRef = db.collection('users');
    final userBillsDocRef = usersCollectionRef.doc(currentUser!.email);

    final newBillsRef = userBillsDocRef.collection('user_bills').doc();

    await newBillsRef.set(billsData);
  }

  Stream<QuerySnapshot> getBillsStream() {
    return
      db
          .collection("users")
          .doc(currentUser!.email)
          .collection("user_bills")
          .orderBy("dueDate", descending: true)
          .snapshots();
  }
}