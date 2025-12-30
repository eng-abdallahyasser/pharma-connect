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
        // Send all images in 'images' field
        final imageFiles = await Future.wait(
          images.map(
            (image) async => await dio.MultipartFile.fromFile(image.path),
          ),
        );
        data['images'] = imageFiles;

        // Convert to FormData to handle file upload
        payload = dio.FormData.fromMap(data);
      }

      final response = await _apiClient.post('/api/service-requests', payload);
      return PharmacyRequest.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  
}
