import 'package:chef_lunch/models/menu_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  final Stream<QuerySnapshot> menu =
      FirebaseFirestore.instance.collection('menu').snapshots();

  List<MenuModel> menuList = [];
  HomeProvider() {
    init();
  }

  void getFoods() {
    menu.map(
      (e) {
        menuList = e.docs.map(
          (DocumentSnapshot document) {
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            return MenuModel.fromJson(data);
          },
        ).toList();
      },
    );
    notifyListeners();
  }

  void init() {
    menu.listen((event) {
      getFoods();
    });
  }
}
