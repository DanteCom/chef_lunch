import 'package:chef_lunch/components/my_cart_container.dart';
import 'package:chef_lunch/providers/cart_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
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
        centerTitle: true,
        title: const Text(
          'Cart',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: GestureDetector(
              onTap: () {
                state.deleteList();
              },
              child: const Icon(Icons.delete),
            ),
          ),
        ],
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
                      return MyCartContainer(model: cartList[index]);
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '\$ ${state.getTotalPrice()}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () async {
                    final result = state.cartList.isEmpty
                        ? null
                        : await showDialog(
                            context: context,
                            builder: (context) {
                              TextEditingController numberController =
                                  TextEditingController();

                              return AlertDialog(
                                titlePadding: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 30),
                                title: Column(
                                  children: [
                                    TextField(
                                      controller: numberController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .tertiary),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary),
                                        ),
                                        hintText: 'Enter your number',
                                        hintStyle: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      children: [
                                        const Spacer(),
                                        CupertinoButton(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 6,
                                          ),
                                          color: Theme.of(context)
                                              .colorScheme
                                              .inversePrimary,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: const Text('Cancel'),
                                          onPressed: () {
                                            Navigator.pop(context);
                                            numberController.clear();
                                          },
                                        ),
                                        const SizedBox(width: 10),
                                        CupertinoButton(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 15,
                                            vertical: 6,
                                          ),
                                          color: Theme.of(context)
                                              .colorScheme
                                              .inversePrimary,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: const Text('Save'),
                                          onPressed: () {
                                            if (numberController.text.length ==
                                                11) {
                                              return Navigator.pop(
                                                context,
                                                numberController.text,
                                              );
                                            }
                                            return;
                                          },
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              );
                            },
                          );
                    if (result == null) {
                      return;
                    }
                    // ignore: use_build_context_synchronously
                    state.addOrderToBase(result, context);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 80, vertical: 25),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text('Checkout'),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
