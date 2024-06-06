import 'package:chef_lunch/components/my_button.dart';
import 'package:chef_lunch/models/menu_model.dart';
import 'package:chef_lunch/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FoodPage extends StatefulWidget {
  final MenuModel foodInfo;
  const FoodPage({
    super.key,
    required this.foodInfo,
  });

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  int quantity = 1;

  void increment() {
    quantity++;
    setState(() {});
  }

  void decrement() {
    if (quantity != 1) {
      quantity--;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final stateCart = context.watch<CartProvider>();
    return Scaffold(
      body: Column(
        children: [
          Stack(
            alignment: Alignment.topLeft,
            children: [
              Image.network(
                widget.foodInfo.image,
                width: double.infinity,
                height: 350,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 50,
                left: 20,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent.withOpacity(.2),
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.foodInfo.name,
                    style: const TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          decrement();
                        },
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).colorScheme.secondary,
                              width: 2,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.remove,
                            color: Theme.of(context).colorScheme.secondary,
                            size: 23,
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: SizedBox(
                            width: 30,
                            child: Text(
                              quantity.toString(),
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          increment();
                        },
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .inversePrimary
                                .withOpacity(.25),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.add,
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '\$${widget.foodInfo.price}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1.5,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'coment to food' * 8,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Spacer(flex: 2),
                ],
              ),
            ),
          ),
          MyButton(
            onTab: () {
              stateCart.addToCart(widget.foodInfo, quantity);
              Navigator.pop(context);
            },
            text: 'Add Cart',
          ),
          const SizedBox(height: 35),
        ],
      ),
    );
  }
}
