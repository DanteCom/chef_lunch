import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference orders =
      FirebaseFirestore.instance.collection('oreders');
  Future<void> saveOrderToDataBase(String receipt) async {
    await orders.add({
      'date': DateTime.now(),
      'receipt': receipt,
    });
  }
}
