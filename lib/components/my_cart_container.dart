import 'package:chef_lunch/models/menu_model.dart';
import 'package:chef_lunch/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyCartContainer extends StatelessWidget {
  final int index;
  final int quantity;
  final MenuModel foodInfo;
  const MyCartContainer({
    super.key,
    required this.foodInfo,
    required this.quantity,
    required this.index,
  });
  @override
  Widget build(BuildContext context) {
    final state = context.watch<CartProvider>();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.inversePrimary,
      ),
      child: Row(
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image(
              image: NetworkImage(foodInfo.image),
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            foodInfo.name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 10),
          Text(
            quantity.toString(),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          IconButton(
              onPressed: () {
                state.deleteFood(index);
              },
              icon: const Icon(Icons.remove))
        ],
      ),
    );
  }
}
