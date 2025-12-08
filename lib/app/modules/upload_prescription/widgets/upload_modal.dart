import 'package:flutter/material.dart';
import 'upload_form.dart';

// Upload modal widget for prescription upload dialog
class UploadModal extends StatelessWidget {
  final String doctorName;
  final String notes;
  final ValueChanged<String> onDoctorNameChanged;
  final ValueChanged<String> onNotesChanged;
  final VoidCallback onUploadPressed;
  final VoidCallback onClosePressed;
  final bool isUploading;
  final double uploadProgress;

  const UploadModal({
    Key? key,
    required this.doctorName,
    required this.notes,
    required this.onDoctorNameChanged,
    required this.onNotesChanged,
    required this.onUploadPressed,
    required this.onClosePressed,
    this.isUploading = false,
    this.uploadProgress = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 500),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A73E8),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Title
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Upload Prescription',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Add your medical documents',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),

                    // Close button
                    GestureDetector(
                      onTap: isUploading ? null : onClosePressed,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Content
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // File upload section
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A73E8).withOpacity(0.05),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFF1A73E8).withOpacity(0.2),
                          width: 2,
                          strokeAlign: BorderSide.strokeAlignOutside,
                        ),
                      ),
                      child: Column(
                        children: [
                          // Upload icon
                          Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              color: const Color(0xFF1A73E8).withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.cloud_upload,
                              color: Color(0xFF1A73E8),
                              size: 32,
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Upload text
                          const Text(
                            'Select or drag file here',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1F2937),
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            'PDF, JPG, PNG (Max 10MB)',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),

                          const SizedBox(height: 12),

                          // Browse button
                          ElevatedButton.icon(
                            onPressed: isUploading
                                ? null
                                : () {
                                    // TODO: Implement file picker
                                  },
                            icon: const Icon(Icons.folder_open, size: 16),
                            label: const Text('Browse Files'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1A73E8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Form
                    UploadForm(
                      doctorName: doctorName,
                      notes: notes,
                      onDoctorNameChanged: onDoctorNameChanged,
                      onNotesChanged: onNotesChanged,
                      onUploadPressed: onUploadPressed,
                      isUploading: isUploading,
                      uploadProgress: uploadProgress,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
