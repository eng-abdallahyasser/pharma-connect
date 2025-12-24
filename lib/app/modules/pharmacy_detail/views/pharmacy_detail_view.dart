import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/pharmacy_detail_controller.dart';
import '../widgets/pharmacy_header.dart';
import '../widgets/quick_stats.dart';
import '../widgets/pharmacy_info.dart';
import '../widgets/doctor_card.dart';

// Pharmacy detail view - main screen for pharmacy details
class PharmacyDetailView extends GetView<PharmacyDetailController> {
  const PharmacyDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: Obx(() {
        final pharmacy = controller.pharmacy.value;

        // Show loading or default UI while pharmacy is loading
        if (pharmacy == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              // Header with image
              PharmacyHeader(
                pharmacy: pharmacy,
                onBackPressed: () => Get.back(),
                onSharePressed: controller.sharePharmacy,
              ),

              // Tabs
              Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    // Overview tab
                    Expanded(
                      child: GestureDetector(
                        onTap: () => controller.selectTab('overview'),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color:
                                    controller.selectedTab.value == 'overview'
                                    ? const Color(0xFF1A73E8)
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                          ),
                          child: Text(
                            'Overview',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: controller.selectedTab.value == 'overview'
                                  ? const Color(0xFF1A73E8)
                                  : Colors.grey[600],
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Doctors tab
                    Expanded(
                      child: GestureDetector(
                        onTap: () => controller.selectTab('doctors'),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: controller.selectedTab.value == 'doctors'
                                    ? const Color(0xFF1A73E8)
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                          ),
                          child: Text(
                            'Doctors (${controller.getAllDoctors().length})',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: controller.selectedTab.value == 'doctors'
                                  ? const Color(0xFF1A73E8)
                                  : Colors.grey[600],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Content
              Padding(
                padding: const EdgeInsets.all(16),
                child: Obx(() {
                  if (controller.selectedTab.value == 'overview') {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Quick stats
                        QuickStats(
                          doctorsCount: controller.getAllDoctors().length,
                          availableCount: controller.getAvailableDoctorsCount(),
                          rating: pharmacy.rating,
                        ),

                        const SizedBox(height: 24),

                        // Pharmacy info
                        PharmacyInfo(pharmacy: pharmacy),

                        const SizedBox(height: 24),

                        // Available doctors preview
                        if (controller.getAvailableDoctorsCount() > 0) ...[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Available Doctors',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF1F2937),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => controller.selectTab('doctors'),
                                child: const Text(
                                  'View All',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF1A73E8),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Column(
                            children: List.generate(
                              (controller.getAvailableDoctorsCount() > 2
                                  ? 2
                                  : controller.getAvailableDoctorsCount()),
                              (index) {
                                final doctor = controller
                                    .getAvailableDoctors()[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: DoctorCard(
                                    doctor: doctor,
                                    onBookPressed: () =>
                                        controller.bookAppointment(doctor.id),
                                    onChatPressed: () =>
                                        controller.chatWithDoctor(doctor.id),
                                    isPreview: true,
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],

                        // Action buttons
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: controller.getDirections,
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Column(
                                  children: const [
                                    Icon(Icons.navigation, size: 20),
                                    SizedBox(height: 4),
                                    Text(
                                      'Directions',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: OutlinedButton(
                                onPressed: controller.callPharmacy,
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Column(
                                  children: const [
                                    Icon(Icons.phone, size: 20),
                                    SizedBox(height: 4),
                                    Text(
                                      'Call',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: OutlinedButton(
                                onPressed: controller.openRatingDialog,
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Column(
                                  children: const [
                                    Icon(Icons.star_outline, size: 20),
                                    SizedBox(height: 4),
                                    Text(
                                      'Rate',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        ElevatedButton.icon(
                          onPressed: controller.orderMedicines,
                          icon: const Icon(Icons.shopping_bag),
                          label: const Text('Order Medicines'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1A73E8),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            minimumSize: const Size(double.infinity, 48),
                          ),
                        ),
                      ],
                    );
                  } else {
                    // Doctors tab
                    return Column(
                      children: List.generate(
                        controller.getAllDoctors().length,
                        (index) {
                          final doctor = controller.getAllDoctors()[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: DoctorCard(
                              doctor: doctor,
                              onBookPressed: () =>
                                  controller.bookAppointment(doctor.id),
                              onChatPressed: () =>
                                  controller.chatWithDoctor(doctor.id),
                            ),
                          );
                        },
                      ),
                    );
                  }
                }),
              ),
            ],
          ),
        );
      }),
    );
  }
}
