import 'package:dio/dio.dart' as dio;
import '../../../../core/network/api_client.dart';
import '../models/pharmacy_request_model.dart';
import '../models/item_model.dart';
import 'package:image_picker/image_picker.dart';

class PharmacyRequestRepository {
  final ApiClient _apiClient = ApiClient();

  Future<PharmacyRequest> createRequest(
    String branchId,
    ServiceRequestType type,
    String? notes,
    List<ManualItem> manualItems,
    List<SelectedItem> selectedItems,
    List<XFile> images,
  ) async {
    try {
      final Map<String, dynamic> data = {
        'branch': {'id': branchId},
        'type': type.name,
        'notes': notes,
        'manualItems': manualItems.map((e) => e.toJson()).toList(),
        'selectedItems': selectedItems.map((e) => e.toJson()).toList(),
      };

      dynamic payload = data;

      if (images.isNotEmpty) {
        // Send the first image in 'image' field
        data['image'] = await dio.MultipartFile.fromFile(images.first.path);
        // Convert to FormData to handle file upload
        payload = dio.FormData.fromMap(data);
      }

      final response = await _apiClient.post('/api/service-requests', payload);
      return PharmacyRequest.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  // Poll for request status updates
  Stream<dynamic> listenToRequestStatus(String requestId) async* {
    yield* Stream.periodic(const Duration(seconds: 5), (_) async {
      try {
        final response = await _apiClient.get(
          '/api/service-requests/$requestId/stream',
        );
        return response;
      } catch (e) {
        return null; // Handle error or ignore
      }
    }).asyncMap((event) async => await event).where((event) => event != null);
  }
}
