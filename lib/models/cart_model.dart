import 'package:hive/hive.dart';

import 'package:chef_lunch/models/menu_model.dart';

part 'cart_model.g.dart';

@HiveType(typeId: 1)
class CartModel {
  @HiveField(0)
  MenuModel foodInfo;
  @HiveField(1)
  int quantity;
  CartModel({
    required this.foodInfo,
    this.quantity = 1,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'foodInfo': foodInfo.toJson(),
      'quantity': quantity,
    };
  }

  factory CartModel.fromJson(Map<String, dynamic> map) {
    return CartModel(
      foodInfo: MenuModel.fromJson(map['foodInfo'] as Map<String, dynamic>),
      quantity: map['quantity'] as int,
    );
  }
}
