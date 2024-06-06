import 'package:chef_lunch/components/my_menu_card.dart';
import 'package:chef_lunch/page/food_page.dart';
import 'package:chef_lunch/page/profile.page.dart';
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
      appBar: AppBar(
        elevation: 15,
        centerTitle: true,
        title: const Text(
          'Home',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfilePage(),
                  )),
              child: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.person),
              ),
            ),
          ),
        ],
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : foodList.isEmpty
              ? const Center(
                  child: Text(
                    'No Foods available',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                )
              : ListView.separated(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
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
