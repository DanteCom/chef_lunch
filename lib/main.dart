import 'dart:async';

import 'package:chef_lunch/models/cart_model.dart';
import 'package:chef_lunch/models/menu_model.dart';
import 'package:chef_lunch/providers/cart_provider.dart';
import 'package:chef_lunch/providers/home_provider.dart';
import 'package:chef_lunch/providers/order_provider.dart';
import 'package:chef_lunch/services/auth/auth_gate.dart';
import 'package:chef_lunch/firebase_options.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(CartModelAdapter());
  Hive.registerAdapter(MenuModelAdapter());
  await Hive.openBox<CartModel>('chefLunch');
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

ValueNotifier<bool> isDeviceConnected = ValueNotifier(false);

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StreamSubscription? sub;

  Future<void> getConnectivity() async {
    isDeviceConnected.value = await InternetConnectionChecker().hasConnection;
  }

  @override
  void initState() {
    getConnectivity();

    sub = Connectivity().onConnectivityChanged.listen((result) async {
      await getConnectivity();
    });
    super.initState();
  }

  @override
  void dispose() {
    sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => OrderProvider(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthGate(),
      ),
    );
  }
}
