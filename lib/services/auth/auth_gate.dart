import 'package:chef_lunch/main.dart';
import 'package:chef_lunch/page/connection_page.dart';
import 'package:chef_lunch/providers/pages_provider.dart';
import 'package:chef_lunch/services/auth/login_or_register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isDeviceConnected,
      builder: (context, hasConnection, child) {
        if (!hasConnection) {
          return const ConnectionPage();
        }

        return StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const PagesProvider();
            } else {
              return const LoginOrRegister();
            }
          },
        );
      },
    );
  }
}
