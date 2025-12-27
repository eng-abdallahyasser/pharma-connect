import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Attachment menu widget for selecting file types to attach
class AttachmentMenu extends StatelessWidget {
  final VoidCallback onPhotoPressed;
  final VoidCallback onDocumentPressed;
  final VoidCallback onMedicalReportPressed;

  const AttachmentMenu({
    super.key,
    required this.onPhotoPressed,
    required this.onDocumentPressed,
    required this.onMedicalReportPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // White card with rounded corners and shadow
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Theme.of(context).dividerColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor,
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Photo attachment option
          _buildAttachmentOption(
            context,
            icon: Icons.image,
            label: 'chat.attachment_photo'.tr,
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: onPhotoPressed,
          ),

          // Document attachment option
          _buildAttachmentOption(
            context,
            icon: Icons.description,
            label: 'chat.attachment_document'.tr,
            backgroundColor: Theme.of(context).colorScheme.secondary,
            onPressed: onDocumentPressed,
          ),

          // Medical report attachment option
          _buildAttachmentOption(
            context,
            icon: Icons.file_present,
            label: 'chat.attachment_medical_report'.tr,
            backgroundColor: Theme.of(context).colorScheme.tertiary,
            onPressed: onMedicalReportPressed,
          ),
        ],
      ),
    );
  }

  // Build individual attachment option
  Widget _buildAttachmentOption(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color backgroundColor,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon container
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: backgroundColor.withAlpha(26),
            ),
            child: Center(child: Icon(icon, color: backgroundColor, size: 24)),
          ),
          const SizedBox(height: 8),

          // Label
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).textTheme.bodyMedium?.color,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
