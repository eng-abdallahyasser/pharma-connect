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

      if (response is List) {
        return response.map((json) => DoctorModel.fromJson(json)).toList();
      }

      log('Unexpected response format: $response');
      return [];
    } catch (e) {
      log('Error fetching nearby doctors: $e');
      rethrow;
    }
  }
}
