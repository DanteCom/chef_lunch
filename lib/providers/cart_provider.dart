import 'package:chef_lunch/models/cart_model.dart';
import 'package:chef_lunch/models/menu_model.dart';
import 'package:chef_lunch/models/order_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CartProvider extends ChangeNotifier {
  final orders = FirebaseFirestore.instance.collection('orders');
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  int totalPrice = 0;
  List<CartModel> cartList = [];
  void deleteList() {
    cartList.clear();
  }

  void deleteFood(int index) {
    cartList.removeAt(index);
    notifyListeners();
  }

  void addToCart(MenuModel foodInfo, int quantity) {
    try {
      final a =
          cartList.firstWhere((element) => element.foodInfo.id == foodInfo.id);
      a.quantity += quantity;
    } catch (e) {
      cartList.add(
        CartModel(
          quantity: quantity,
          foodInfo: foodInfo,
        ),
      );
    }
    for (var price in cartList) {
      totalPrice += price.foodInfo.price * quantity;
    }
  }

  Future addOrderToBase() async {
    final data = DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());
    await orders.add(
      OrderModel(
        userId: _firebaseAuth.currentUser!.uid,
        location: 'cairo',
        phone: '01550320404',
        totalPrice: totalPrice,
        data: data,
        foodInfo: cartList,
      ).toJson(),
    );
    cartList.clear();
  }
}
