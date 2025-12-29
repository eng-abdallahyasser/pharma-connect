import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/medicines_controller.dart';
import '../widgets/family_member_selector.dart';
import '../widgets/next_reminder_banner.dart';
import '../widgets/progress_card.dart';
import '../widgets/medicine_card.dart';
import '../widgets/medicine_detail_modal.dart';

// Medicines view - main screen for managing medicines
class MedicinesView extends GetView<MedicinesController> {
  const MedicinesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header with title and next reminder
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
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
                    'medicines.my_medicines'.tr,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Next reminder banner
                  Obx(() {
                    final nextMedicine = controller.getNextMedicineReminder();
                    return NextReminderBanner(
                      memberName: controller.selectedMember.value?.name ?? '',
                      nextMedicine: nextMedicine,
                    );
                  }),
                ],
              ),
            ),

            // Main content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Family members selector
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'medicines.family_members'.tr,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Obx(
                        () => FamilyMemberSelector(
                          familyMembers: controller.getAllFamilyMembers(),
                          selectedMember: controller.selectedMember.value,
                          onMemberSelected: controller.selectMember,
                          onAddMemberPressed: () {
                            // TODO: Implement add family member
                            Get.snackbar('Add Member', 'Coming soon');
                          },
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Progress card
                  Obx(() {
                    final member = controller.selectedMember.value;
                    if (member == null) {
                      return const SizedBox.shrink();
                    }

                    return ProgressCard(
                      memberName: member.name,
                      takenToday: member.totalTakenToday,
                      totalToday: member.totalDosesToday,
                      progressPercentage: member.progressPercentage,
                    );
                  }),

                  const SizedBox(height: 24),

                  // Medicines list header
                  Obx(() {
                    final member = controller.selectedMember.value;
                    final medicinesCount = member?.medicinesCount ?? 0;

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'medicines.member_medicines'.trParams({
                            'name': member?.name ?? '',
                            'count': '$medicinesCount',
                          }),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            // TODO: Implement add medicine
                            Get.snackbar('medicines.add_new'.tr, 'Coming soon');
                          },
                          icon: Icon(
                            Icons.add,
                            size: 16,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                          label: Text(
                            'medicines.add_new'.tr,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.primary,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),

                  const SizedBox(height: 12),

                  // Medicines list or empty state
                  Obx(() {
                    final medicines = controller
                        .getMedicinesForSelectedMember();

                    if (medicines.isEmpty) {
                      return Container(
                        padding: const EdgeInsets.symmetric(vertical: 48),
                        child: Column(
                          children: [
                            Icon(
                              Icons.medication,
                              size: 48,
                              color: Theme.of(context).colorScheme.outline,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'medicines.no_medicines'.tr,
                              style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton.icon(
                              onPressed: () {
                                // TODO: Implement add medicine
                                Get.snackbar(
                                  'medicines.add_new'.tr,
                                  'Coming soon',
                                );
                              },
                              icon: Icon(
                                Icons.add,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                              label: Text(
                                'medicines.add_first_medicine'.tr,
                                style: TextStyle(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onPrimary,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(
                                  context,
                                ).colorScheme.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return Column(
                      children: List.generate(
                        medicines.length,
                        (index) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: MedicineCard(
                            medicine: medicines[index],
                            onTap: () =>
                                controller.selectMedicine(medicines[index]),
                            onReminderToggle: () =>
                                controller.toggleReminder(medicines[index].id),
                            onMarkAsTaken: () => controller.markMedicineAsTaken(
                              medicines[index].id,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),

      // Medicine detail modal
      floatingActionButton: Obx(() {
        final selectedMedicine = controller.selectedMedicine.value;
        if (selectedMedicine == null) {
          return const SizedBox.shrink();
        }

        return Stack(
          children: [
            // Backdrop
            GestureDetector(
              onTap: controller.clearSelectedMedicine,
              child: Container(color: Colors.black.withAlpha(128)),
            ),

            // Modal
            Center(
              child: MedicineDetailModal(
                medicine: selectedMedicine,
                memberName: controller.selectedMember.value?.name ?? '',
                reminderEnabled: selectedMedicine.reminderEnabled,
                onReminderToggle: () =>
                    controller.toggleReminder(selectedMedicine.id),
                onClose: controller.clearSelectedMedicine,
                onEdit: () {
                  // TODO: Implement edit medicine
                  Get.snackbar('Edit Medicine', 'Coming soon');
                },
              ),
            ),
          ],
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
