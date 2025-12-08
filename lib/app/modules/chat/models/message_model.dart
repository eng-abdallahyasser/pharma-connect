// Message model representing a chat message
class MessageModel {
  final int id;
  final String text;
  final String sender; // "user" or "doctor"
  final String timestamp;
  final String status; // "sent", "delivered", "read"
  final String type; // "text", "image", "file"
  final String? fileUrl; // URL for image or file
  final String? fileName; // Name of the file

  MessageModel({
    required this.id,
    required this.text,
    required this.sender,
    required this.timestamp,
    required this.status,
    this.type = 'text',
    this.fileUrl,
    this.fileName,
  });

  // Check if message is from user
  bool get isFromUser => sender == 'user';

  // Check if message is from doctor
  bool get isFromDoctor => sender == 'doctor';

  // Check if message is read
  bool get isRead => status == 'read';

  // Check if message is delivered
  bool get isDelivered => status == 'delivered';

  // Check if message is sent
  bool get isSent => status == 'sent';

  // Check if message is text type
  bool get isTextMessage => type == 'text';

  // Check if message is image type
  bool get isImageMessage => type == 'image';

  // Check if message is file type
  bool get isFileMessage => type == 'file';

  // Create a copy with modified fields
  MessageModel copyWith({
    int? id,
    String? text,
    String? sender,
    String? timestamp,
    String? status,
    String? type,
    String? fileUrl,
    String? fileName,
  }) {
    return MessageModel(
      id: id ?? this.id,
      text: text ?? this.text,
      sender: sender ?? this.sender,
      timestamp: timestamp ?? this.timestamp,
      status: status ?? this.status,
      type: type ?? this.type,
      fileUrl: fileUrl ?? this.fileUrl,
      fileName: fileName ?? this.fileName,
    );
  }
}
