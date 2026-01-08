import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_client_sse/constants/sse_request_type_enum.dart';
import 'package:flutter_client_sse/flutter_client_sse.dart';
import 'package:get/get.dart';
import 'package:pharma_connect/app/core/network/api_constants.dart';
import 'package:pharma_connect/app/core/services/storage_service.dart';
import '../data/models/pharmacy_request_model.dart';
import '../data/models/message_model.dart';
import '../data/providers/pharmacy_request_repository.dart';

class PharmacyRequestStatusController extends GetxController {
  final Rx<PharmacyRequest> request = Rx<PharmacyRequest>(
    Get.arguments as PharmacyRequest,
  );
  final StorageService storageService = Get.find<StorageService>();
  final PharmacyRequestRepository _repository = PharmacyRequestRepository();

  final messages = <Message>[].obs;
  final isLoadingMessages = false.obs;
  final isSendingMessage = false.obs;
  final TextEditingController messageController = TextEditingController();

  String get currentUserId => storageService.getUser()?.id ?? '';

  @override
  void onInit() {
    super.onInit();
    fetchMessages();
    _startMonitoring();
  }

  @override
  void onClose() {
    messageController.dispose();
    unsubscribeFromRequestStatus();
    super.onClose();
  }

  final RxBool isConnected = false.obs;

  void _startMonitoring() {
    isConnected.value = true;

    listenToRequestStatus(request.value.id).listen(
      (data) {
        isConnected.value = true;
        try {
          if (data.isEmpty) return; // Skip empty keep-alive or error parses

          log(name: "PharmacyRequestStatusController", " stream data: $data");

          // Check if data is a message (has content or type TEXT)
          if (data['type'] == 'TEXT' || data['content'] != null) {
            try {
              // Pass 'data' directly since it contains the message fields
              final newMessage = Message.fromJson(data);

              // Avoid duplicates
              if (!messages.any((m) => m.id == newMessage.id)) {
                messages.add(newMessage);
              }
            } catch (e) {
              log(
                name: "PharmacyRequestStatusController",
                "Error parsing message from stream: $e",
              );
            }
          } else {
            // Handle partial updates using copyWith (request status updates)
            request.value = request.value.copyWith(
              status: data['status'] as String?,
              notes: data['notes'] as String?,
              doctor: data['doctor'] != null
                  ? DoctorInfo.fromJson(data['doctor'] as Map<String, dynamic>)
                  : null,
            );
          }

          // Log the update for debugging
          log(
            name: "PharmacyRequestStatusController",
            "Updated request status: ${request.value.status}",
          );
        } catch (e) {
          log(
            name: "PharmacyRequestStatusController",
            "Error parsing update: $e",
          );
        }
      },
      onError: (error) {
        log(name: "PharmacyRequestStatusController", "Stream error: $error");
        isConnected.value = false;
      },
      onDone: () {
        log(name: "PharmacyRequestStatusController", "Stream closed");
        isConnected.value = false;
      },
    );
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

  // Poll for request status updates
  Stream<Map<String, dynamic>> listenToRequestStatus(String requestId) {
    final token = storageService.getToken();

    return SSEClient.subscribeToSSE(
          method: SSERequestType.GET,
          url: '${ApiConstants.baseUrl}/api/service-requests/$requestId/stream',
          header: {
            "Authorization": "Bearer $token",
            "Accept": "text/event-stream",
            "Cache-Control": "no-cache",
            "Connection": "keep-alive",
          },
        )
        .map((event) {
          if (event.data != null && event.data!.isNotEmpty) {
            try {
              return jsonDecode(event.data!) as Map<String, dynamic>;
            } catch (e) {
              return <String, dynamic>{"message": "Error parsing update: $e"};
            }
          }
          return <String, dynamic>{"message": "no data received"};
        })
        .where((data) => data.isNotEmpty);
  }

  void unsubscribeFromRequestStatus() {
    SSEClient.unsubscribeFromSSE();
  }

  Future<void> fetchMessages() async {
    try {
      isLoadingMessages.value = true;
      final fetchedMessages = await _repository.getMessages(request.value.id);
      messages.assignAll(fetchedMessages);
    } catch (e) {
      log('Error fetching messages: $e');
    } finally {
      isLoadingMessages.value = false;
    }
  }

  Future<void> sendMessage() async {
    final content = messageController.text.trim();
    if (content.isEmpty) return;

    try {
      isSendingMessage.value = true;
      final newMessage = await _repository.sendMessage(
        request.value.id,
        content,
      );
      if (!messages.any((m) => m.id == newMessage.id)) {
        messages.add(newMessage);
      }
      messageController.clear();
      // Optionally scroll to bottom
    } catch (e) {
      log('Error sending message: $e');
      Get.snackbar('Error', 'Failed to send message');
    } finally {
      isSendingMessage.value = false;
    }
  }
}
