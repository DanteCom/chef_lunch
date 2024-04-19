import 'package:chef_lunch/models/menu_model.dart';

class CartModel {
  dynamic quantityl;
  List<MenuModel> foodInfo = [];
  CartModel({
    required this.quantityl,
    required this.foodInfo,
  });
}
