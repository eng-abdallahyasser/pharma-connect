import 'package:pharma_connect/app/core/network/api_client.dart';

class ProfileRepository {
  final ApiClient _apiClient = ApiClient();

  Future<dynamic> getMedicalProfile() async {
    return await _apiClient.get('/api/profile/medical');
  }

  Future<dynamic> updateMedicalProfile(Map<String, dynamic> data) async {
    return await _apiClient.patch('/api/profile/medical', data);
  }
}
