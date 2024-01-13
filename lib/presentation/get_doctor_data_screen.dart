import 'package:flutter/material.dart';

class GetDoctorDataScreen extends StatefulWidget {
  const GetDoctorDataScreen({super.key});

  @override
  State<GetDoctorDataScreen> createState() => _GetDoctorDataScreenState();
}

class _GetDoctorDataScreenState extends State<GetDoctorDataScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Text("GetDoctorDataScreen"),
      ),
    );
  }
}
