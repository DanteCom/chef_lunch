import 'package:chef_lunch/components/my_order_container.dart';
import 'package:chef_lunch/providers/order_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<OrderProvider>();
    final foodList = state.orderList;
    return Scaffold(
      appBar: AppBar(
        elevation: 15,
        title: const Text('My Orders'),
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : foodList.isEmpty
              ? const Center(
                  child: Text(
                    'No Foods avialable',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                )
              : SafeArea(
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 12),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 20),
                          itemCount: foodList.length,
                          itemBuilder: (context, index) {
                            return MyOrderContainer(
                              foodId: state.foodIds[index],
                              orderInfo: foodList[index],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
