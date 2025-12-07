import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharma_connect/app/modules/home/controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pharmacy Connect'), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to Pharma Connect',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Obx(
              () => Text(
                'Counter: ${controller.count.value}',
                style: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: controller.decrement,
                  child: const Text('Decrease'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: controller.increment,
                  child: const Text('Increase'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: controller.reset,
                  child: const Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
