import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/pharmacy_request_status_controller.dart';

class PharmacyRequestStatusView
    extends GetView<PharmacyRequestStatusController> {
  const PharmacyRequestStatusView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            const Text('Request Status'),
            Obx(
              () => Text(
                controller.isConnected.value ? 'Connected' : 'Disconnected',
                style: TextStyle(
                  fontSize: 12,
                  color: controller.isConnected.value
                      ? Colors.green
                      : Colors.red,
                ),
              ),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            Obx(
              () => Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: controller.getStatusColor().withAlpha(26),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _getStatusIcon(controller.request.value.status),
                  size: 48,
                  color: controller.getStatusColor(),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Obx(
              () => Text(
                controller.getStatusText(),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: controller.getStatusColor(),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Request NO: ${controller.request.value.requestNo}',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 48),
            _buildInfoCard(context),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Get.offAllNamed('/home'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Back to Home'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getStatusIcon(String status) {
    switch (status.toUpperCase()) {
      case 'PENDING':
        return Icons.access_time_filled;
      case 'ACCEPTED':
      case 'APPROVED':
        return Icons.check_circle;
      case 'REJECTED':
        return Icons.cancel;
      case 'COMPLETED':
        return Icons.task_alt;
      default:
        return Icons.info;
    }
  }

  Widget _buildInfoCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Request Details',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildInfoRow('Type', controller.request.value.type.name),
            const SizedBox(height: 12),
            _buildInfoRow(
              'Medicine Items',
              '${controller.request.value.manualItems.length}',
            ),
            if (controller.request.value.notes != null) ...[
              const SizedBox(height: 12),
              _buildInfoRow('Notes', controller.request.value.notes!),
            ],
            if (controller.request.value.doctor != null) ...[
              const SizedBox(height: 12),
              _buildInfoRow('Doctor ID', controller.request.value.doctor!.id),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
      ],
    );
  }
}
