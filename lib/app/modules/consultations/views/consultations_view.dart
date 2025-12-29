import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/consultations_controller.dart';
import '../widgets/doctor_card.dart';
import '../widgets/consultation_card.dart';
import '../widgets/consultation_tabs.dart';

// Consultations view - main screen for doctor consultations
class ConsultationsView extends GetView<ConsultationsController> {
  const ConsultationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header with search bar
            Container(
              // Blue background matching design
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).padding.top),

                  // Header title
                  Text(
                    'consultations.title'.tr,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Search bar
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        // Search icon
                        Icon(
                          Icons.search,
                          color: Theme.of(context).hintColor,
                          size: 20,
                        ),
                        const SizedBox(width: 8),

                        // Search input
                        Expanded(
                          child: TextField(
                            onChanged: controller.updateSearchQuery,
                            decoration: InputDecoration(
                              fillColor: Theme.of(context).cardColor,
                              hintStyle: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    color: Theme.of(context).hintColor,
                                  ),

                              hintText: 'consultations.search_placeholder'.tr,
                              enabledBorder:
                                  InputBorder.none, // For enabled state
                              focusedBorder:
                                  InputBorder.none, // For focused state
                              disabledBorder:
                                  InputBorder.none, // For disabled state
                              errorBorder: InputBorder.none, // For error state
                              focusedErrorBorder:
                                  InputBorder.none, // For error+focused state
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 12,
                              ),
                            ),
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.color,
                            ),
                          ),
                        ),
                        const SizedBox(width: 28),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Main content area
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tab navigation
                  Obx(
                    () => ConsultationTabs(
                      currentIndex: controller.currentTabIndex.value,
                      onTabChanged: controller.changeTab,
                      upcomingCount: controller.getUpcomingCount(),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Tab content
                  Obx(() {
                    final tabIndex = controller.currentTabIndex.value;

                    // Available Doctors Tab
                    if (tabIndex == 0) {
                      return Column(
                        children: [
                          // Filtered doctors list
                          ...controller.getFilteredDoctors().map((doctor) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: DoctorCard(
                                doctor: doctor,
                                onChat: () => controller.chatWithDoctor(doctor),
                                onCall: () => controller.callDoctor(doctor),
                                onBook: () =>
                                    controller.bookConsultation(doctor),
                              ),
                            );
                          }),

                          // Empty state if no doctors match search
                          if (controller.getFilteredDoctors().isEmpty)
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 32,
                                ),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.person_search,
                                      size: 48,
                                      color: Theme.of(context).disabledColor,
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      'consultations.no_doctors'.tr,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Theme.of(context).hintColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'consultations.no_doctors_hint'.tr,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Theme.of(context).hintColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      );
                    }
                    // Upcoming Consultations Tab
                    else if (tabIndex == 1) {
                      final upcoming = controller.getAllUpcoming();
                      return Column(
                        children: [
                          if (upcoming.isEmpty)
                            // Empty state
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 32,
                                ),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.calendar_today,
                                      size: 48,
                                      color: Theme.of(context).disabledColor,
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      'consultations.no_upcoming'.tr,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Theme.of(context).hintColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'consultations.no_upcoming_hint'.tr,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Theme.of(context).hintColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          else
                            // Upcoming consultations list
                            ...upcoming.map((consultation) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: ConsultationCard(
                                  consultation: consultation,
                                  isPast: false,
                                  onActionPressed: () {
                                    if (consultation.isVideoCall) {
                                      controller.startVideoCall(consultation);
                                    } else if (consultation.isChat) {
                                      controller.joinChat(consultation);
                                    }
                                  },
                                  onReschedule: () {
                                    controller.rescheduleConsultation(
                                      consultation,
                                    );
                                  },
                                  onCancel: () {
                                    controller.cancelConsultation(consultation);
                                  },
                                ),
                              );
                            }),
                        ],
                      );
                    }
                    // History Tab
                    else {
                      final past = controller.getAllPast();
                      return Column(
                        children: [
                          if (past.isEmpty)
                            // Empty state
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 32,
                                ),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.history,
                                      size: 48,
                                      color: Theme.of(context).disabledColor,
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      'consultations.no_history'.tr,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Theme.of(context).hintColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'consultations.no_history_hint'.tr,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Theme.of(context).hintColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          else
                            // Past consultations list
                            ...past.map((consultation) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: ConsultationCard(
                                  consultation: consultation,
                                  isPast: true,
                                  onActionPressed: () {
                                    if (consultation.hasPrescription) {
                                      controller.viewPrescription(consultation);
                                    }
                                  },
                                ),
                              );
                            }),
                        ],
                      );
                    }
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
