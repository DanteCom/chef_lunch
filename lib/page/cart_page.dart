import 'package:chef_lunch/components/my_button.dart';
import 'package:chef_lunch/components/my_cart_container.dart';
import 'package:chef_lunch/providers/cart_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({
    super.key,
  });

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  CartProvider cartProvider = CartProvider();
  final orders = FirebaseFirestore.instance.collection('orders');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 15,
        title: Row(
          children: [
            const Spacer(),
            const Text('Cart'),
            const Spacer(),
            const SizedBox(width: 25),
            GestureDetector(
              onTap: () {
                cartProvider.delete();
              },
              child: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: cartProvider.cartItems.isEmpty
                ? const Center(
                    child: Text('Cart Empty'),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 15),
                    itemCount: cartProvider.cartItems.length,
                    itemBuilder: (context, index) {
                      return MyCartContainer(
                        name:
                            cartProvider.cartItems[index].foodInfo[index].name,
                        image:
                            cartProvider.cartItems[index].foodInfo[index].image,
                      );
                    },
                  ),
          ),
          MyButton(
            onTab: () {},
            text: 'Add Order',
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
