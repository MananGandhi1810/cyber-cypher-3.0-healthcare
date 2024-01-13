import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cyber_cypher_healthcare/presentation/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GetDataScreen extends StatefulWidget {
  const GetDataScreen({super.key});

  @override
  State<GetDataScreen> createState() => _GetDataScreenState();
}

class _GetDataScreenState extends State<GetDataScreen> {
  TextEditingController _ageController = TextEditingController();
  TextEditingController _heightFootController = TextEditingController();
  TextEditingController _heightInchController = TextEditingController();
  TextEditingController _weightController = TextEditingController();
  String _gender = "Male";
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var auth = FirebaseAuth.instance;

  void _saveData() {
    firestore
        .collection("users")
        .doc(auth.currentUser!.uid)
        .collection("data")
        .doc("physical_data")
        .set({
      "age": _ageController.text,
      "height": _heightFootController.text +
          " ft " +
          _heightInchController.text +
          " in",
      "weight": _weightController.text,
      "gender": _gender,
    });
    debugPrint("Data saved");
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const SplashScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Form(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const Text('Get Data'),
                  TextFormField(
                    controller: _ageController,
                    decoration: const InputDecoration(
                      labelText: 'Age',
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _heightFootController,
                          decoration: const InputDecoration(
                            labelText: 'Height (in foot)',
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          controller: _heightInchController,
                          decoration: const InputDecoration(
                            labelText: 'Height (in inch)',
                          ),
                        ),
                      ),
                    ],
                  ),

                  TextFormField(
                    controller: _weightController,
                    decoration: const InputDecoration(
                      labelText: 'Weight (in kg)',
                    ),
                  ),
                  // Gender radio button
                  RadioListTile(
                    title: const Text('Male'),
                    value: 'Male',
                    groupValue: _gender,
                    onChanged: (value) {
                      setState(() {
                        _gender = 'Male';
                      });
                    },
                  ),
                  RadioListTile(
                    title: const Text('Female'),
                    value: 'Female',
                    groupValue: _gender,
                    onChanged: (value) {
                      setState(() {
                        _gender = 'Female';
                      });
                    },
                  ),
                  TextButton(
                    onPressed: () {
                      _saveData();
                    },
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
