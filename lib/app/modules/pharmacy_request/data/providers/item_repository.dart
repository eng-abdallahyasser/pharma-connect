import 'dart:developer';

import 'package:pharma_connect/app/core/network/api_exceptions.dart';

import '../../../../core/network/api_client.dart';
import '../models/item_model.dart';

class ItemRepository {
  final ApiClient _apiClient = ApiClient();

  Future<List<Item>> searchItems(String query) async {
    try {
      final response = await _apiClient.get(
        '/api/items',
        queryParams: {'limit': 10, 'search': query},
      );

      // Assuming response is a list or contains a list in 'data'
      // If the API follows standard pagination structure it might be inside 'data'
      // Based on previous repositories, let's assume it might return the list directly or a paginated response.
      // The user prompt said: get {{HOST}}/api/items?limit=5&search=de
      // Usually checking response structure is safer.

      List<dynamic> data;
      if (response is List) {
        data = response;
      } else if (response['data'] != null && response['data'] is List) {
        data = response['data'];
      } else {
        return [];
      }

      return data.map((e) => Item.fromJson(e)).toList();
    } catch (e) {
      if (e is ApiException) {
        log('Error searching itemscv: ${e.response}');
      } else {
        log('Error searching items: ${e.toString()}');
      }
      return [];
    }
  }
}
