import 'package:chef_lunch/components/my_button.dart';
import 'package:chef_lunch/components/my_cart_container.dart';
import 'package:chef_lunch/providers/cart_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final orders = FirebaseFirestore.instance.collection('orders');

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CartProvider>();
    final cartList = state.cartList;
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
                state.deleteList();
                setState(() {});
              },
              child: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: cartList.isEmpty
                ? const Center(
                    child: Text('Cart Empty'),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 15),
                    itemCount: cartList.length,
                    itemBuilder: (context, index) {
                      return MyCartContainer(
                        index: index,
                        foodInfo: cartList[index].foodInfo,
                        quantity: cartList[index].quantity,
                      );
                    },
                  ),
          ),
          MyButton(
            onTab: () {
              state.addOrderToBase();
              Navigator.pop(context);
            },
            text: 'Add Order',
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
