import 'package:chef_lunch/components/my_drawer.dart';
import 'package:chef_lunch/components/my_menu_card.dart';
import 'package:chef_lunch/page/cart_page.dart';
import 'package:chef_lunch/providers/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final foodList = context.watch<HomeProvider>().menuList;
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
      body: ListView.separated(
        itemBuilder: (context, index) => MyMenuCard(
          image: foodList[index].image.toString(),
          name: foodList[index].name.toString(),
          price: foodList[index].price.toString(),
          onTab: () {},
        ),
        separatorBuilder: (context, index) => const SizedBox(height: 25),
        itemCount: foodList.length,
      ),
    );
  }
}
