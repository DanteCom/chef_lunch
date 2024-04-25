import 'package:chef_lunch/page/orders_page.dart';
import 'package:chef_lunch/services/auth/auth_service.dart';
import 'package:chef_lunch/components/my_drawer_title.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    void logOut() async {
      final authService = AuthService();
      await authService.signOut();
    }

    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Icon(
              Icons.lock_open_rounded,
              size: 80,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25),
            child: Divider(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          MyDrawerTitle(
            text: 'H O M E',
            icon: Icons.home,
            onTab: () => Navigator.pop(context),
          ),
          MyDrawerTitle(
            text: 'S E T T I N G S',
            icon: Icons.settings,
            onTab: () => Navigator.pop(context),
          ),
          MyDrawerTitle(
            text: 'MY O R D E R S',
            icon: Icons.info,
            onTab: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const OrdersPage(),
              ),
            ),
          ),
          const Spacer(),
          MyDrawerTitle(
            text: 'L O G O U T',
            icon: Icons.logout_rounded,
            onTab: logOut,
          ),
          const SizedBox(height: 25),
        ],
      ),
    );
  }
}
