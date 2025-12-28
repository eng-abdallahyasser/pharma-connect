import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/doctor_request_controller.dart';

class DoctorRequestView extends GetView<DoctorRequestController> {
  const DoctorRequestView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('DoctorRequestView'), centerTitle: true),
      body: const Center(
        child: Text(
          'DoctorRequestView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
