import 'dart:developer';
import 'package:get/get.dart';
import '../models/doctor_model.dart';
import 'doctors_repository.dart';

class DoctorsService extends GetxService {
  final _isLoading = false.obs;
  final _doctors = <DoctorModel>[].obs;
  late DoctorsRepository _doctorsRepository;

  bool get isLoading => _isLoading.value;
  List<DoctorModel> get doctors => _doctors;

  @override
  void onInit() {
    super.onInit();
    _doctorsRepository = DoctorsRepository();
  }

  /// Fetch nearby doctors based on location
  Future<List<DoctorModel>> fetchNearbyDoctors({
    required double lat,
    required double lng,
    required double radius,
  }) async {
    _isLoading.value = true;
    try {
      final doctors = await _doctorsRepository.getNearbyDoctors(
        lat: lat,
        lng: lng,
        radius: radius,
      );

      _doctors.value = doctors;
      log('Fetched ${doctors.length} nearby doctors');
      return doctors;
    } catch (e) {
      log('Error fetching nearby doctors: $e');
      return [];
    } finally {
      _isLoading.value = false;
    }
  }

  /// Clear doctors list
  void clearDoctors() {
    _doctors.clear();
  }
}
