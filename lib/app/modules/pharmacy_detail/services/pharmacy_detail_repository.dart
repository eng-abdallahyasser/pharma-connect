import 'dart:developer';
import 'package:pharma_connect/app/core/network/api_client.dart';
import 'package:pharma_connect/app/core/network/api_constants.dart';
import '../models/pharmacy_detail_model.dart';

class PharmacyDetailRepository {
  final ApiClient _apiClient = ApiClient();

  Future<PharmacyDetailModel> getPharmacyDetail(String id) async {
    try {
      final response = await _apiClient.get(
        '${ApiConstants.getBranchDetails}$id',
      );
      return PharmacyDetailModel.fromJson(response);
    } catch (e) {
      log("Error fetching pharmacy detail: $e");
      rethrow;
    }
  }
}
