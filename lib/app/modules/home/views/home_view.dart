import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../controllers/home_controller.dart';
import '../widgets/quick_action_card.dart';
import '../widgets/doctor_card.dart';
import '../widgets/pharmacy_card.dart';
import '../widgets/health_tip_card.dart';
import '../controllers/address_controller.dart';
import '../widgets/addresses_bottom_sheet.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Bar with Location and Notification
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFF1A73E8),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).padding.top),

                  // Location and Notification Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.bottomSheet(
                            const AddressesBottomSheet(),
                            isScrollControlled: true,
                          );
                        },
                        child: Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: Colors.white,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'home.location'.tr,
                                  style: Theme.of(context).textTheme.labelSmall
                                      ?.copyWith(color: Colors.white70),
                                ),
                                Obx(() {
                                  final addressController =
                                      Get.find<AddressController>();
                                  final selectedAddress =
                                      addressController.selectedAddress.value;
                                  return Text(
                                    selectedAddress?.label ??
                                        'Tap to add address',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  );
                                }),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Stack(
                        children: [
                          IconButton(
                            onPressed: controller.onNavigateToNotifications,
                            icon: const Icon(
                              Icons.notifications_none,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Color(0xFFFF6B6B),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Search Bar
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.search,
                          color: Color(0xFF6B7280),
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            onChanged: controller.updateSearchQuery,

                            decoration: InputDecoration(
                              hintText: 'home.search_placeholder'.tr,
                              // For default border
                              enabledBorder:
                                  InputBorder.none, // For enabled state
                              focusedBorder:
                                  InputBorder.none, // For focused state
                              disabledBorder:
                                  InputBorder.none, // For disabled state
                              errorBorder: InputBorder.none, // For error state
                              focusedErrorBorder:
                                  InputBorder.none, // For error+focused state
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.mic,
                          color: Color(0xFF6B7280),
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Main Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Quick Actions Section
                  Text(
                    'home.quick_actions'.tr,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      QuickActionCard(
                        icon: Icons.camera_alt,
                        title: 'home.upload_prescription'.tr,
                        bgColor: const Color(0xFF1A73E8).withAlpha(26),
                        iconColor: const Color(0xFF1A73E8),
                      ),
                      QuickActionCard(
                        icon: FontAwesomeIcons.stethoscope,
                        title: 'home.consult_doctor'.tr,
                        bgColor: const Color(0xFF00C897).withAlpha(26),
                        iconColor: const Color(0xFF00C897),
                      ),
                      QuickActionCard(
                        icon: Icons.medication,
                        title: 'home.my_medicine'.tr,
                        bgColor: const Color(0xFF906398).withAlpha(26),
                        iconColor: const Color(0xFF906398),
                        onTap: controller.onNavigateToMedicines,
                      ),
                      QuickActionCard(
                        icon: Icons.store,
                        title: 'home.nearby_pharmacies'.tr,
                        bgColor: Colors.orange.withAlpha(26),
                        iconColor: Colors.orange,
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  // Available Doctors Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'home.available_doctors'.tr,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'home.see_all'.tr,
                          style: const TextStyle(
                            color: Color(0xFF1A73E8),
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 200,

                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.doctors.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 12, 12),
                          child: DoctorCard(
                            doctor: controller.doctors[index],
                            onChat: () => controller.onChatWithDoctor(
                              controller.doctors[index],
                            ),
                            onCall: () {},
                            onBook: () {},
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Nearby Pharmacies Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'home.nearby_pharmacies'.tr,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'home.view_map'.tr,
                          style: const TextStyle(
                            color: Color(0xFF1A73E8),
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.pharmacies.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: PharmacyCard(
                          pharmacy: controller.pharmacies[index],
                          onSelect: () => controller.onPharmacySelect(
                            controller.pharmacies[index],
                          ),
                          onOrder: () {},
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 32),
                  // Health Tips Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'home.health_tips'.tr,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'home.view_all'.tr,
                          style: const TextStyle(
                            color: Color(0xFF1A73E8),
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.healthTips.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: HealthTipCard(
                            tip: controller.healthTips[index],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
