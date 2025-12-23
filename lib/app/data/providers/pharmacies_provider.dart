import 'package:pharma_connect/app/core/network/api_client.dart';
import 'package:pharma_connect/app/core/network/api_constants.dart';

class PharmaciesProvider {
  Future<dynamic> searchBranches({
    String? search,
    int page = 1,
    int limit = 20,
  }) async {
    final query = <String, dynamic>{
      'page': page.toString(),
      'limit': limit.toString(),
    };

    if (search != null && search.isNotEmpty) {
      query['search'] = search;
    }

    return await ApiClient().get(ApiConstants.getBranches, queryParams: query);
  }

  Future<dynamic> getNearbyBranches({
    required double lat,
    required double lng,
    int radius = 5,
    int limit = 20,
    int page = 1,
  }) async {
    final query = <String, dynamic>{
      'lat': lat.toString(),
      'lng': lng.toString(),
      'radius': radius.toString(),
      'limit': limit.toString(),
      'page': page.toString(),
    };

    return await ApiClient().get(
      ApiConstants.getNearbyBranches,
      queryParams: query,
    );
  }

  Future<dynamic> getBranchDetails(String id) async {
    return await ApiClient().get('${ApiConstants.getBranchDetails}$id');
  }
}
