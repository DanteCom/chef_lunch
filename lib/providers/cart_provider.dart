import 'package:chef_lunch/models/cart_model.dart';
import 'package:chef_lunch/models/menu_model.dart';
import 'package:chef_lunch/providers/home_provider.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  HomeProvider homeProvider = HomeProvider();
  List<CartModel> cartItems = [];
  int quantity = 1;
  void decrement() {
    if (quantity != 1) {
      quantity--;
    }
  }

  void increment() {
    quantity != quantity;
    quantity++;
  }

  void addToCart() {
    for (var info in homeProvider.menuList) {
      return cartItems.add(
        CartModel(
          quantityl: quantity,
          foodInfo: [
            MenuModel(name: info.name, price: info.price, image: info.image),
          ],
        ),
      );
    }
  }

  void delete() {
    cartItems.clear();
  }
}
