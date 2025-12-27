import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/doctor_detail_controller.dart';
import '../widgets/doctor_header.dart';
import '../widgets/doctor_info_section.dart';
import '../widgets/doctor_stats_card.dart';
import '../widgets/time_slot_picker.dart';
import '../widgets/date_selector.dart';
import '../widgets/action_buttons.dart';

// Doctor detail view - main screen for viewing doctor details and booking
class DoctorDetailView extends GetView<DoctorDetailController> {
  const DoctorDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Obx(() {
        final doctor = controller.doctor.value;

        // Show loading or error state
        if (doctor == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(color: colorScheme.primary),
                const SizedBox(height: 16),
                Text(
                  'Loading doctor details...',
                  style: TextStyle(
                    color: colorScheme.onSurface.withAlpha(154),
                  ),
                ),
              ],
            ),
          );
        }

        return Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  floating: false,
                  pinned: true,
                  backgroundColor: colorScheme.primary,
                  elevation: 0,
                  leading: IconButton(
                    onPressed: () => Get.back(),
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(52),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                  title: const Text(
                    'Doctor Profile',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  centerTitle: true,
                  actions: [
                    IconButton(
                      onPressed: () {
                        Get.snackbar('Share', 'Sharing doctor profile...');
                      },
                      icon: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(52),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.share_outlined,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            colorScheme.primary,
                            colorScheme.primary.withAlpha(204),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      const SizedBox(height: 20), // Spacing from app bar
                      // Doctor header with avatar
                      // transform: Matrix4.translationValues(0.0, -40.0, 0.0), // Optional: overlap effect
                      DoctorHeader(doctor: doctor),

                      // Stats cards
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: DoctorStatsCard(
                          rating: controller.formattedRating,
                          totalRaters: doctor.totalRaters,
                          distance: controller.distanceText,
                          isOnline: doctor.isOnline,
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Doctor information section
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: DoctorInfoSection(doctor: doctor),
                      ),

                      const SizedBox(height: 24),

                      // Date selector
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: DateSelector(
                          selectedDate: controller.selectedDate.value,
                          onDateSelected: controller.selectDate,
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Time slot picker
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TimeSlotPicker(
                          timeSlots: controller.availableTimeSlots,
                          selectedSlot: controller.selectedTimeSlot.value,
                          onSlotSelected: controller.selectTimeSlot,
                        ),
                      ),

                      const SizedBox(height: 100), // Space for bottom buttons
                    ],
                  ),
                ),
              ],
            ),

            // Bottom action buttons
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: ActionButtons(
                isOnline: doctor.isOnline,
                isLoading: controller.isLoading.value,
                onChat: controller.chatWithDoctor,
                onCall: controller.callDoctor,
                onRate: controller.openRatingDialog,
                onBook: controller.bookAppointment,
              ),
            ),
          ],
        );
      }),
    );
  }
}
