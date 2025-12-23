import 'dart:developer';

import 'package:pharma_connect/app/core/network/api_client.dart';

class ProfileRepository {
  final ApiClient _apiClient = ApiClient();

  Future<dynamic> getMedicalProfile() async {
    final response = await _apiClient.get('/api/profile/medical');
    log("Medical Profile Response : $response");
    return response;
  }

  Future<dynamic> updateMedicalProfile(Map<String, dynamic> data) async {
    log("Medical Profile Data : $data");
    return await _apiClient.patch('/api/profile/medical', data);
  }

  Future<dynamic> updateUserProfile(Map<String, dynamic> data) async {
    log("Update Profile Data : $data");
    return await _apiClient.patch('/api/profile', data);
  }
}
