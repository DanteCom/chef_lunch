import 'package:chef_lunch/models/menu_model.dart';

class OrderModel {
  final List foodInfo;
  final String location;
  final String phone;
  final int quantity;
  OrderModel({
    required this.location,
    required this.phone,
    required this.quantity,
    required this.foodInfo,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'foodInfo': foodInfo.map((e) => e.toJson()).toList(),
      'phone': phone,
      'location': location,
      'quantity': quantity,
    };
  }

  factory OrderModel.fromJson(Map<String, dynamic> map) {
    return OrderModel(
      foodInfo: List<MenuModel>.from(
        (map['foodInfo'] as List<int>).map(
          (e) => MenuModel.fromJson(e as Map<String, dynamic>),
        ),
      ),
      location: map['location'] as String,
      phone: map['phone'] as String,
      quantity: map['quantity'] as int,
    );
  }
}
