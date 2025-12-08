import 'package:flutter/material.dart';

// Attachment menu widget for selecting file types to attach
class AttachmentMenu extends StatelessWidget {
  final VoidCallback onPhotoPressed;
  final VoidCallback onDocumentPressed;
  final VoidCallback onMedicalReportPressed;

  const AttachmentMenu({
    Key? key,
    required this.onPhotoPressed,
    required this.onDocumentPressed,
    required this.onMedicalReportPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // White card with rounded corners and shadow
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.grey[200]!,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
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
            icon: Icons.image,
            label: 'Photo',
            backgroundColor: const Color(0xFF1A73E8),
            onPressed: onPhotoPressed,
          ),

          // Document attachment option
          _buildAttachmentOption(
            icon: Icons.description,
            label: 'Document',
            backgroundColor: const Color(0xFF00C897),
            onPressed: onDocumentPressed,
          ),

          // Medical report attachment option
          _buildAttachmentOption(
            icon: Icons.file_present,
            label: 'Medical Report',
            backgroundColor: const Color(0xFFA855F7),
            onPressed: onMedicalReportPressed,
          ),
        ],
      ),
    );
  }

  // Build individual attachment option
  Widget _buildAttachmentOption({
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
              color: backgroundColor.withOpacity(0.1),
            ),
            child: Center(
              child: Icon(
                icon,
                color: backgroundColor,
                size: 24,
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Label
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF1F2937),
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
