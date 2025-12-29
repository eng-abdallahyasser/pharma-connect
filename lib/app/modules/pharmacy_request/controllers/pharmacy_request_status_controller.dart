import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/models/pharmacy_request_model.dart';
import '../data/providers/pharmacy_request_repository.dart';

class PharmacyRequestStatusController extends GetxController {
  final PharmacyRequestRepository _repository = PharmacyRequestRepository();
  final Rx<PharmacyRequest> request = Rx<PharmacyRequest>(
    Get.arguments as PharmacyRequest,
  );

  @override
  void onInit() {
    super.onInit();
    _startMonitoring();
  }

  void _startMonitoring() {
    _repository.listenToRequestStatus(request.value.id).listen((data) {
      if (data != null) {
        try {
          request.value = PharmacyRequest.fromJson(data);

          // Check for terminal states to maybe show a success message or stop polling?
          // For now, just update the UI.
        } catch (e) {
          log('Error parsing update: $e');
        }
      }
    });
  }

  Color getStatusColor() {
    switch (request.value.status.toUpperCase()) {
      case 'PENDING':
        return Colors.orange;
      case 'ACCEPTED':
      case 'APPROVED':
        return Colors.green;
      case 'REJECTED':
      case 'declined':
        return Colors.red;
      case 'COMPLETED':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  String getStatusText() {
    return request.value.status.toUpperCase().replaceAll('_', ' ');
  }
}
