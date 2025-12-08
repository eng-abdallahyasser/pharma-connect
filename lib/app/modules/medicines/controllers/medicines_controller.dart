import 'package:get/get.dart';
import '../models/medicine_model.dart';
import '../models/family_medicines_model.dart';

// Medicines controller manages medicines and family members' medicines
class MedicinesController extends GetxController {
  // Observable properties for reactive UI updates
  final familyMembers = <FamilyMedicinesModel>[].obs;
  final selectedMember = Rxn<FamilyMedicinesModel>();
  final selectedMedicine = Rxn<MedicineModel>();

  @override
  void onInit() {
    super.onInit();
    // Initialize family members and medicines
    _initializeFamilyMembers();
    // Set first member as selected
    if (familyMembers.isNotEmpty) {
      selectedMember.value = familyMembers[0];
    }
  }

  // Initialize family members with sample medicines data
  void _initializeFamilyMembers() {
    familyMembers.value = [
      // Self
      FamilyMedicinesModel(
        id: 1,
        name: 'You',
        relation: 'Self',
        imageUrl:
            'https://images.unsplash.com/photo-1659353888906-adb3e0041693?w=200',
        medicines: [
          MedicineModel(
            id: 1,
            name: 'Aspirin',
            dosage: '100mg',
            frequency: 'Twice Daily',
            times: ['08:00 AM', '08:00 PM'],
            color: '#3B82F6', // Blue
            reminderEnabled: true,
            takenToday: 1,
            totalToday: 2,
            instructions: 'Take after meals',
            startDate: 'Dec 1, 2024',
            endDate: 'Dec 15, 2024',
          ),
          MedicineModel(
            id: 2,
            name: 'Vitamin D3',
            dosage: '1000 IU',
            frequency: 'Once Daily',
            times: ['09:00 AM'],
            color: '#FBBF24', // Yellow
            reminderEnabled: true,
            takenToday: 1,
            totalToday: 1,
            instructions: 'Take with breakfast',
            startDate: 'Nov 20, 2024',
          ),
          MedicineModel(
            id: 3,
            name: 'Ibuprofen',
            dosage: '400mg',
            frequency: 'Three times daily',
            times: ['08:00 AM', '02:00 PM', '10:00 PM'],
            color: '#EF4444', // Red
            reminderEnabled: true,
            takenToday: 2,
            totalToday: 3,
            instructions: 'Take with food',
            startDate: 'Dec 3, 2024',
            endDate: 'Dec 10, 2024',
          ),
        ],
      ),

      // Mother
      FamilyMedicinesModel(
        id: 2,
        name: 'Sarah Johnson',
        relation: 'Mother',
        imageUrl:
            'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=200',
        medicines: [
          MedicineModel(
            id: 4,
            name: 'Metformin',
            dosage: '500mg',
            frequency: 'Twice Daily',
            times: ['07:30 AM', '07:30 PM'],
            color: '#22C55E', // Green
            reminderEnabled: true,
            takenToday: 1,
            totalToday: 2,
            instructions: 'Take before meals',
            startDate: 'Oct 15, 2024',
          ),
          MedicineModel(
            id: 5,
            name: 'Lisinopril',
            dosage: '10mg',
            frequency: 'Once Daily',
            times: ['08:00 AM'],
            color: '#EC4899', // Pink
            reminderEnabled: true,
            takenToday: 1,
            totalToday: 1,
            instructions: 'For blood pressure',
            startDate: 'Sep 1, 2024',
          ),
        ],
      ),

      // Daughter
      FamilyMedicinesModel(
        id: 3,
        name: 'Emma Johnson',
        relation: 'Daughter',
        imageUrl:
            'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=200',
        medicines: [
          MedicineModel(
            id: 6,
            name: 'Children\'s Multivitamin',
            dosage: '1 gummy',
            frequency: 'Once Daily',
            times: ['09:00 AM'],
            color: '#F97316', // Orange
            reminderEnabled: true,
            takenToday: 1,
            totalToday: 1,
            instructions: 'Take with breakfast',
            startDate: 'Nov 1, 2024',
          ),
        ],
      ),
    ];
  }

  // Select a family member
  void selectMember(FamilyMedicinesModel member) {
    selectedMember.value = member;
    selectedMedicine.value = null; // Clear selected medicine
  }

  // Select a medicine to view details
  void selectMedicine(MedicineModel medicine) {
    selectedMedicine.value = medicine;
  }

  // Clear selected medicine
  void clearSelectedMedicine() {
    selectedMedicine.value = null;
  }

  // Toggle reminder for a medicine
  void toggleReminder(int medicineId) {
    if (selectedMember.value == null) return;

    final member = selectedMember.value!;
    final medicineIndex =
        member.medicines.indexWhere((m) => m.id == medicineId);

    if (medicineIndex != -1) {
      final medicine = member.medicines[medicineIndex];
      member.medicines[medicineIndex] =
          medicine.copyWith(reminderEnabled: !medicine.reminderEnabled);

      // Update selected medicine if it's the one being toggled
      if (selectedMedicine.value?.id == medicineId) {
        selectedMedicine.value = member.medicines[medicineIndex];
      }

      // Trigger update
      selectedMember.refresh();
    }
  }

  // Mark medicine as taken
  void markMedicineAsTaken(int medicineId) {
    if (selectedMember.value == null) return;

    final member = selectedMember.value!;
    final medicineIndex =
        member.medicines.indexWhere((m) => m.id == medicineId);

    if (medicineIndex != -1) {
      final medicine = member.medicines[medicineIndex];
      if (medicine.takenToday < medicine.totalToday) {
        member.medicines[medicineIndex] =
            medicine.copyWith(takenToday: medicine.takenToday + 1);
        selectedMember.refresh();
      }
    }
  }

  // Get next medicine reminder for selected member
  MedicineModel? getNextMedicineReminder() {
    return selectedMember.value?.getNextMedicine();
  }

  // Add new medicine to selected member
  Future<void> addMedicine(MedicineModel medicine) async {
    try {
      if (selectedMember.value == null) return;

      final member = selectedMember.value!;
      member.medicines.add(medicine);
      selectedMember.refresh();

      Get.snackbar('Success', 'Medicine added successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to add medicine: $e');
    }
  }

  // Remove medicine from selected member
  Future<void> removeMedicine(int medicineId) async {
    try {
      if (selectedMember.value == null) return;

      final member = selectedMember.value!;
      member.medicines.removeWhere((m) => m.id == medicineId);
      selectedMember.refresh();

      Get.snackbar('Success', 'Medicine removed successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to remove medicine: $e');
    }
  }

  // Add new family member
  Future<void> addFamilyMember(FamilyMedicinesModel member) async {
    try {
      familyMembers.add(member);
      Get.snackbar('Success', 'Family member added successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to add family member: $e');
    }
  }

  // Get all family members
  List<FamilyMedicinesModel> getAllFamilyMembers() {
    return familyMembers;
  }

  // Get medicines for selected member
  List<MedicineModel> getMedicinesForSelectedMember() {
    return selectedMember.value?.medicines ?? [];
  }

  // Get total progress for selected member
  double getProgressForSelectedMember() {
    return selectedMember.value?.progressPercentage ?? 0;
  }
}
