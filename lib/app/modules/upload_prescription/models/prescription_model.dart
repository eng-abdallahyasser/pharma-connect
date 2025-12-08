// Prescription model representing a prescription upload
class PrescriptionModel {
  final String id;
  final String fileName;
  final String fileSize;
  final String uploadDate;
  final String doctorName;
  final String? notes;
  final bool isVerified;
  final double uploadProgress;

  PrescriptionModel({
    required this.id,
    required this.fileName,
    required this.fileSize,
    required this.uploadDate,
    required this.doctorName,
    this.notes,
    this.isVerified = false,
    this.uploadProgress = 0.0,
  });

  // Get file type from file name
  String get fileType {
    final extension = fileName.split('.').last.toLowerCase();
    return extension;
  }

  // Check if file is image
  bool get isImage => ['jpg', 'jpeg', 'png', 'gif'].contains(fileType);

  // Check if file is PDF
  bool get isPdf => fileType == 'pdf';

  // Get file icon based on type
  String get fileIcon {
    if (isImage) return '🖼️';
    if (isPdf) return '📄';
    return '📎';
  }

  // Create a copy with modified fields
  PrescriptionModel copyWith({
    String? id,
    String? fileName,
    String? fileSize,
    String? uploadDate,
    String? doctorName,
    String? notes,
    bool? isVerified,
    double? uploadProgress,
  }) {
    return PrescriptionModel(
      id: id ?? this.id,
      fileName: fileName ?? this.fileName,
      fileSize: fileSize ?? this.fileSize,
      uploadDate: uploadDate ?? this.uploadDate,
      doctorName: doctorName ?? this.doctorName,
      notes: notes ?? this.notes,
      isVerified: isVerified ?? this.isVerified,
      uploadProgress: uploadProgress ?? this.uploadProgress,
    );
  }
}
