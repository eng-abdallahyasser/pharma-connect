import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:pharma_connect/app/core/services/storage_service.dart';
import 'api_constants.dart';
import 'api_exceptions.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;
  ApiClient._internal();
  
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: Duration(milliseconds: ApiConstants.connectTimeout),
      receiveTimeout: Duration(milliseconds: ApiConstants.receiveTimeout),
      headers: ApiConstants.headers,
    ),
  );
  
  // Add interceptors
  void init() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Add token if exists
          final token = Get.find<StorageService>().getToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (DioException error, handler) {
          // Handle errors globally
          return handler.next(error);
        },
      ),
    );
  }
  
  Future<dynamic> get(String endpoint, {Map<String, dynamic>? queryParams}) async {
    try {
      final response = await _dio.get(endpoint, queryParameters: queryParams);
      return response.data;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }
  
  Future<dynamic> post(String endpoint, dynamic data) async {
    try {
      final response = await _dio.post(endpoint, data: data);
      return response.data;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }
  
  Future<dynamic> put(String endpoint, dynamic data) async {
    try {
      final response = await _dio.put(endpoint, data: data);
      return response.data;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }
  
  Future<dynamic> delete(String endpoint) async {
    try {
      final response = await _dio.delete(endpoint);
      return response.data;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }
  // Patch method for updating profile image
  Future<dynamic> patch(String endpoint, dynamic data) async {
    try {
      final response = await _dio.patch(endpoint, data: data);
      return response.data;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }
}