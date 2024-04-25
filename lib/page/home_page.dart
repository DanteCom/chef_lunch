import 'package:chef_lunch/components/my_drawer.dart';
import 'package:chef_lunch/components/my_menu_card.dart';
import 'package:chef_lunch/page/cart_page.dart';
import 'package:chef_lunch/page/food_page.dart';
import 'package:chef_lunch/providers/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<HomeProvider>();
    final foodList = state.menuList;
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(
        elevation: 15,
        title: Row(
          children: [
            const Spacer(),
            const Text('Home'),
            const Spacer(),
            const SizedBox(width: 25),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CartPage(),
                  ),
                );
              },
              child: const Icon(Icons.shopping_cart),
            ),
          ],
        ),
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
              : ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 12)
                      .copyWith(top: 15),
                  itemCount: foodList.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 15),
                  itemBuilder: (context, index) => MyMenuCard(
                    foodInfo: foodList[index],
                    onTab: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FoodPage(
                            foodInfo: foodList[index],
                          ),
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}
