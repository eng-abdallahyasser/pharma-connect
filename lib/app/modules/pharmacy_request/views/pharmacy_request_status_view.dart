import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/pharmacy_request_status_controller.dart';
import '../data/models/message_model.dart';

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
        // backgroundColor: Colors.white,
        // foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(24.0),
              children: [
                const SizedBox(height: 40),
                Center(
                  child: Obx(
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
                ),
                const SizedBox(height: 24),
                Center(
                  child: Obx(
                    () => Text(
                      controller.getStatusText(),
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: controller.getStatusColor(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Center(
                  child: Text(
                    'Request NO: ${controller.request.value.requestNo}',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ),
                const SizedBox(height: 48),
                _buildInfoCard(context),
                const SizedBox(height: 24),
                _buildChatSection(),
                const SizedBox(height: 24),
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
          _buildChatInput(context),
        ],
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
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.onSurface.withAlpha(26),
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
              _buildInfoRow(
                'Doctor ID',
                controller.request.value.doctor!.fullName,
              ),
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

  Widget _buildChatSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Messages",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Obx(() {
          if (controller.isLoadingMessages.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.messages.isEmpty) {
            return Center(
              child: Text(
                "No messages yet",
                style: TextStyle(color: Colors.grey[400]),
              ),
            );
          }
          return Column(
            children: controller.messages
                .map(
                  (msg) => _MessageBubble(
                    message: msg,
                    isMe: msg.senderId == controller.currentUserId,
                  ),
                )
                .toList(),
          );
        }),
      ],
    );
  }

  Widget _buildChatInput(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(24),
              ),
              child: TextField(
                controller: controller.messageController,
                decoration: const InputDecoration(
                  hintText: "Type a message...",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Obx(
            () => IconButton(
              onPressed: controller.isSendingMessage.value
                  ? null
                  : () => controller.sendMessage(),
              icon: controller.isSendingMessage.value
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.send, color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final Message message;
  final bool isMe;

  const _MessageBubble({required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isMe ? Colors.blue : Colors.grey[200],
          borderRadius: BorderRadius.circular(16).copyWith(
            bottomRight: isMe ? Radius.zero : null,
            bottomLeft: isMe ? null : Radius.zero,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              message.content,
              style: TextStyle(color: isMe ? Colors.white : Colors.black87),
            ),
            const SizedBox(height: 4),
            // We assume createdAt is DateTime. If String, parse it.
            Text(
              _formatTime(message.createdAt),
              style: TextStyle(
                fontSize: 10,
                color: isMe ? Colors.white70 : Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
  }
}
