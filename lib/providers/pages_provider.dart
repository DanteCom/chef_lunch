import 'package:chef_lunch/page/cart_page.dart';
import 'package:chef_lunch/page/home_page.dart';
import 'package:chef_lunch/page/orders_page.dart';
import 'package:flutter/material.dart';

class PagesProvider extends StatefulWidget {
  const PagesProvider({super.key});

  @override
  State<PagesProvider> createState() => _HomePageState();
}

class _HomePageState extends State<PagesProvider> {
  List<Widget> pagesList = [
    const OrdersPage(),
    const HomePage(),
    const CartPage()
  ];
  int currentIndex = 1;
  void chengePage(int newIndex) {
    currentIndex = newIndex;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pagesList.elementAt(currentIndex),
      bottomNavigationBar: NavigationBar(
        indicatorColor: Theme.of(context).colorScheme.inversePrimary,
        onDestinationSelected: chengePage,
        selectedIndex: currentIndex,
        destinations: const [
          NavigationDestination(
            label: 'My Orders',
            icon: Icon(Icons.info),
          ),
          NavigationDestination(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          NavigationDestination(
            label: 'Cart',
            icon: Icon(Icons.shopping_cart),
          ),
        ],
      ),
    );
  }
}
