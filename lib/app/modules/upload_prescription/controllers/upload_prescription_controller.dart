import 'package:get/get.dart';
import '../models/prescription_model.dart';

// Upload prescription controller manages prescription uploads
class UploadPrescriptionController extends GetxController {
  // Observable properties for reactive UI updates
  final prescriptions = <PrescriptionModel>[].obs;
  final selectedFile = Rxn<PrescriptionModel>();
  final uploadProgress = 0.0.obs;
  final isUploading = false.obs;
  final doctorName = ''.obs;
  final notes = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize with sample prescriptions
    _initializePrescriptions();
  }

  // Initialize prescriptions with sample data
  void _initializePrescriptions() {
    prescriptions.value = [
      PrescriptionModel(
        id: '1',
        fileName: 'Prescription_Dec_2024.pdf',
        fileSize: '2.4 MB',
        uploadDate: 'Dec 8, 2024',
        doctorName: 'Dr. Sarah Johnson',
        notes: 'Take with food, twice daily',
        isVerified: true,
        uploadProgress: 1.0,
      ),
      PrescriptionModel(
        id: '2',
        fileName: 'Medical_Report.pdf',
        fileSize: '1.8 MB',
        uploadDate: 'Dec 5, 2024',
        doctorName: 'Dr. Michael Chen',
        notes: 'Follow-up appointment required',
        isVerified: true,
        uploadProgress: 1.0,
      ),
      PrescriptionModel(
        id: '3',
        fileName: 'Lab_Results.jpg',
        fileSize: '3.2 MB',
        uploadDate: 'Dec 1, 2024',
        doctorName: 'Dr. Emily Roberts',
        isVerified: false,
        uploadProgress: 0.75,
      ),
    ];
  }

  // Select file for preview
  void selectPrescription(PrescriptionModel prescription) {
    selectedFile.value = prescription;
  }

  // Clear selected file
  void clearSelectedPrescription() {
    selectedFile.value = null;
  }

  // Update doctor name
  void updateDoctorName(String name) {
    doctorName.value = name;
  }

  // Update notes
  void updateNotes(String notesText) {
    notes.value = notesText;
  }

  // Simulate file upload
  Future<void> uploadPrescription() async {
    try {
      if (doctorName.value.isEmpty) {
        Get.snackbar('Error', 'Please enter doctor name');
        return;
      }

      isUploading.value = true;
      uploadProgress.value = 0.0;

      // Simulate upload progress
      for (int i = 0; i <= 100; i += 10) {
        await Future.delayed(const Duration(milliseconds: 300));
        uploadProgress.value = i / 100;
      }

      // Create new prescription
      final newPrescription = PrescriptionModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        fileName: 'Prescription_${DateTime.now().toString().split(' ')[0]}.pdf',
        fileSize: '2.5 MB',
        uploadDate: DateTime.now().toString().split(' ')[0],
        doctorName: doctorName.value,
        notes: notes.value.isNotEmpty ? notes.value : null,
        isVerified: false,
        uploadProgress: 1.0,
      );

      // Add to prescriptions list
      prescriptions.insert(0, newPrescription);

      isUploading.value = false;
      uploadProgress.value = 0.0;

      // Clear form
      doctorName.value = '';
      notes.value = '';

      Get.snackbar('Success', 'Prescription uploaded successfully');
      Get.back();
    } catch (e) {
      isUploading.value = false;
      Get.snackbar('Error', 'Failed to upload prescription: $e');
    }
  }

  // Delete prescription
  Future<void> deletePrescription(String prescriptionId) async {
    try {
      prescriptions.removeWhere((p) => p.id == prescriptionId);
      Get.snackbar('Success', 'Prescription deleted');
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete prescription: $e');
    }
  }

  // Download prescription
  Future<void> downloadPrescription(String prescriptionId) async {
    try {
      final prescription =
          prescriptions.firstWhereOrNull((p) => p.id == prescriptionId);
      if (prescription == null) {
        Get.snackbar('Error', 'Prescription not found');
        return;
      }

      // TODO: Implement actual download
      Get.snackbar('Download', 'Downloading ${prescription.fileName}...');
    } catch (e) {
      Get.snackbar('Error', 'Failed to download: $e');
    }
  }

  // Share prescription
  Future<void> sharePrescription(String prescriptionId) async {
    try {
      final prescription =
          prescriptions.firstWhereOrNull((p) => p.id == prescriptionId);
      if (prescription == null) {
        Get.snackbar('Error', 'Prescription not found');
        return;
      }

      // TODO: Implement actual share
      Get.snackbar('Share', 'Sharing ${prescription.fileName}...');
    } catch (e) {
      Get.snackbar('Error', 'Failed to share: $e');
    }
  }

  // Get total prescriptions count
  int getTotalPrescriptions() {
    return prescriptions.length;
  }

  // Get verified prescriptions count
  int getVerifiedCount() {
    return prescriptions.where((p) => p.isVerified).length;
  }

  // Get pending prescriptions count
  int getPendingCount() {
    return prescriptions.where((p) => !p.isVerified).length;
  }
}
