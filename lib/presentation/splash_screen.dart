import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'get_data_screen.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var auth = FirebaseAuth.instance;
  var firestore = FirebaseFirestore.instance;

  void _redirect() {
    auth.authStateChanges().listen((User? user) {
      if (!mounted) return;
      if (user == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
      } else {
        firestore.collection('users').doc(user.uid).collection("data").doc("physical_data").get().then((value) {
          if (value.exists) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const GetDataScreen(),
              ),
            );
          }
        });
      }
    });
  }

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        _redirect();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircleAvatar(
          radius: (MediaQuery.of(context).size.width - 100) / 2,
          backgroundImage: const AssetImage('assets/images/logo.jpg'),
        ),
      ),
    );
  }
}
