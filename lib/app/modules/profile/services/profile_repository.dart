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

  Future<dynamic> getFamilyMembers() async {
    final response = await _apiClient.get('/api/family-members');
    log("Get Family Members Response : $response");
    return response;
  }

  Future<dynamic> addFamilyMember(dynamic data) async {
    log("Add Family Member Data : $data");
    return await _apiClient.post('/api/family-members', data);
  }

  Future<dynamic> deleteFamilyMember(String id) async {
    log("Delete Family Member ID : $id");
    return await _apiClient.delete('/api/family-members/$id');
  }

  Future<dynamic> updateFamilyMember(String id, dynamic data) async {
    log("Update Family Member ID : $id, Data : $data");
    return await _apiClient.patch('/api/family-members/$id', data);
  }
}
