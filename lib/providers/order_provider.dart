import 'package:chef_lunch/models/order_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OrderProvider extends ChangeNotifier {
  final orders = FirebaseFirestore.instance.collection('orders');
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  OrderProvider() {
    init();
  }

  bool isLoading = false;
  List<String> foodIds = [];

  List<OrderModel> orderList = [];
  Future<void> getFoods({bool isInit = false}) async {
    if (isInit) {
      isLoading = true;
      notifyListeners();
    }
    try {
      final foods = await orders.get();
      final newList = foods.docs.map(
        (DocumentSnapshot document) {
          foodIds.add(document.id);
          final data = document.data() as Map<String, dynamic>;
          return OrderModel.fromJson(data);
        },
      ).toList();
      orderList = newList
          .where((element) => element.userId == _firebaseAuth.currentUser!.uid)
          .toList();
    } catch (e) {
      debugPrint('$e');
    } finally {
      if (isInit) {
        await Future.delayed(
          const Duration(milliseconds: 400),
        );
        isLoading = false;
      }
      notifyListeners();
    }
  }

  void init() async {
    await getFoods(isInit: true);
    orders.snapshots().listen((event) {
      getFoods();
    });
  }
}
