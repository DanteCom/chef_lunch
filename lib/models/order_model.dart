import 'package:chef_lunch/models/cart_model.dart';

class OrderModel {
  final List<CartModel> foodInfo;
  final String userId;
  final String location;
  final String phone;
  final String data;
  final int totalPrice;
  OrderModel({
    required this.foodInfo,
    required this.userId,
    required this.location,
    required this.phone,
    required this.data,
    required this.totalPrice,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'foodInfo': foodInfo.map((x) => x.toJson()).toList(),
      'userId': userId,
      'location': location,
      'phone': phone,
      'data': data,
      'totalPrice': totalPrice,
    };
  }

  factory OrderModel.fromJson(Map<String, dynamic> map) {
    return OrderModel(
      foodInfo: List<CartModel>.from(
        (map['foodInfo'] as List<dynamic>).map<CartModel>(
          (x) => CartModel.fromJson(x as Map<String, dynamic>),
        ),
      ),
      userId: map['userId'] as String,
      location: map['location'] as String,
      phone: map['phone'] as String,
      data: map['data'] as String,
      totalPrice: map['totalPrice'] as int,
    );
  }
}
