import 'dart:async';

import 'package:chef_lunch/models/cart_model.dart';
import 'package:chef_lunch/models/menu_model.dart';
import 'package:chef_lunch/models/order_model.dart';
import 'package:chef_lunch/providers/firebase_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class CartProvider extends ChangeNotifier {
  final orders = FirebaseFirestore.instance.collection('orders');
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final box = Hive.box<CartModel>('chefLunch');

  List<CartModel> cartList = [];
  CartProvider() {
    init();
  }

  void deleteList() {
    cartList.clear();
    box.clear();
    notifyListeners();
  }

  void deleteFood(CartModel model) {
    cartList.remove(model);
    box.delete(model.foodInfo.id);
    notifyListeners();
  }

  void decrement(CartModel model) {
    if (model.quantity == 1) {
      deleteFood(model);
      return;
    }

    model.quantity -= 1;
    addToBox(model);
    notifyListeners();
  }

  void increment(CartModel model) {
    model.quantity++;
    addToBox(model);
    notifyListeners();
  }

  Future addToBox(CartModel cartInfo) async {
    box.put(cartInfo.foodInfo.id, cartInfo);
    notifyListeners();
  }

  Future addToCart(MenuModel foodInfo, int quantity) async {
    try {
      final cartListItem =
          cartList.firstWhere((element) => element.foodInfo.id == foodInfo.id);
      cartListItem.quantity += quantity;
      box.put(foodInfo.id, cartListItem);
    } catch (e) {
      final cartItem = CartModel(
        quantity: quantity,
        foodInfo: foodInfo,
      );
      addToBox(cartItem);
      cartList.add(cartItem);
    }
  }

  Future init() async {
    final boxList = box.values.toList();
    cartList = boxList;

    notifyListeners();
  }

  int getTotalPrice() {
    int totalPrice = 0;
    for (var price in cartList) {
      totalPrice += price.foodInfo.price * price.quantity;
    }
    return totalPrice;
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  Future addOrderToBase(phone, context) async {
    Position? position;

    try {
      position = await determinePosition();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'location ruxsat berilmagan',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
          ),
        ),
      );
    }

    getTotalPrice();
    final data = DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());

    await orders.add(
      OrderModel(
        userId: _firebaseAuth.currentUser!.uid,
        location: position != null
            ? "${position.latitude},${position.longitude}"
            : "",
        phone: phone.toString(),
        totalPrice: getTotalPrice(),
        data: data,
        foodInfo: cartList,
        token: await FirebaseApi().initNotifications(),
      ).toJson(),
    );
    cartList.clear();
    box.clear();
    notifyListeners();
  }
}
