import 'package:chef_lunch/components/my_drawer.dart';
import 'package:chef_lunch/components/my_menu_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    CollectionReference menu = FirebaseFirestore.instance.collection('menu');
    return Scaffold(
      appBar: AppBar(
        elevation: 15,
        title: const Text('Home'),
      ),
      drawer: const MyDrawer(),
      body: FutureBuilder<DocumentSnapshot>(
        future: menu.doc().get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return const Text("Document does not exist");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.separated(
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
                itemCount: data.length,
                itemBuilder: (context, index) => MyMenuCard(
                    image: 'assets/images/fastFood.png',
                    text: data['name'].toString(),
                    price: data['price'].toString(),
                    onTab: () {}),
              ),
            );
          }

          return const Text("loading");
        },
      ),
    );
  }
}
