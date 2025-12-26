import 'dart:developer';
import 'package:pharma_connect/app/core/network/api_client.dart';
import 'package:pharma_connect/app/core/network/api_constants.dart';
import '../models/doctor_model.dart';

class DoctorsRepository {
  final ApiClient _apiClient = ApiClient();

  /// Fetch nearby doctors based on location
  Future<List<DoctorModel>> getNearbyDoctors({
    required double lat,
    required double lng,
    required double radius,
  }) async {
    try {
      final queryParams = {
        'lat': lat.toString(),
        'lng': lng.toString(),
        'radius': radius.toString(),
      };

      final response = await _apiClient.get(
        ApiConstants.getNearbyDoctors,
        queryParams: queryParams,
      );

      if (response is Map<String, dynamic> && response['data'] is List) {
        final List<dynamic> dataList = response['data'];
        return dataList
            .map((json) => DoctorModel.fromJson(json as Map<String, dynamic>))
            .toList();
      }

      log('Unexpected response format: $response');
      return [];
    } catch (e) {
      log('Error fetching nearby doctors: $e');
      rethrow;
    }
  }

  /// Rate a doctor
  Future<void> rateDoctor(String id, double rating, String? notes) async {
    try {
      final body = {
        'rating': rating.toInt(), // API expects integer rating
        if (notes != null && notes.isNotEmpty) 'notes': notes,
      };

      await _apiClient.post('/api/doctors/$id/rating', body);
    } catch (e) {
      log('Error rating doctor: $e');
      rethrow;
    }
  }
}
