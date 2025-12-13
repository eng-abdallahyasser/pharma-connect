import 'package:dio/dio.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final Response? response;
  
  ApiException({required this.message, this.statusCode, this.response});
  
  factory ApiException.fromDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiException(message: 'Connection timeout. Please try again.');
        
      case DioExceptionType.badResponse:
        return _handleBadResponse(error.response!);
        
      case DioExceptionType.cancel:
        return ApiException(message: 'Request cancelled');
        
      case DioExceptionType.connectionError:
        return ApiException(message: 'No internet connection');
        
      default:
        return ApiException(message: 'Something went wrong');
    }
  }
  
  static ApiException _handleBadResponse(Response response) {
    switch (response.statusCode) {
      case 400:
        return ApiException(message: 'Bad request', statusCode: 400, response: response);
      case 401:
        return ApiException(message: 'Unauthorized', statusCode: 401, response: response);
      case 403:
        return ApiException(message: 'Forbidden', statusCode: 403, response: response);
      case 404:
        return ApiException(message: 'Not found', statusCode: 404, response: response);
      case 500:
        
        return ApiException(message: 'Server error', statusCode: 500, response: response);
      default:
        return ApiException(
          message: 'Error occurred with status code: ${response.statusCode}',
          statusCode: response.statusCode,
          response: response,
        );
    }
  }
  
  @override
  String toString() => message;
}