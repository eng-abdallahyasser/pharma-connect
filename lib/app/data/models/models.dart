class ChatDoctor {
  final String name;
  final String specialization;
  final String imageUrl;

  ChatDoctor({
    required this.name,
    required this.specialization,
    required this.imageUrl,
  });
}

class PharmacyDetail {
  final int id;
  final String name;
  final String distance;
  final double rating;
  final String workingHours;
  final String imageUrl;
  final bool isOpen;
  final String? address;
  final String? phone;
  final int? totalDoctors;
  final int? availableDoctors;

  PharmacyDetail({
    required this.id,
    required this.name,
    required this.distance,
    required this.rating,
    required this.workingHours,
    required this.imageUrl,
    required this.isOpen,
    this.address,
    this.phone,
    this.totalDoctors,
    this.availableDoctors,
  });
}

class Doctor {
  final int id;
  final String name;
  final String specialization;
  final String imageUrl;
  final double rating;
  final String status; // available, busy, offline

  Doctor({
    required this.id,
    required this.name,
    required this.specialization,
    required this.imageUrl,
    required this.rating,
    required this.status,
  });
}

class Message {
  final int id;
  final String text;
  final String sender; // user, doctor
  final String timestamp;
  final String? status; // sent, delivered, read
  final String? type; // text, image, file
  final String? fileUrl;
  final String? fileName;

  Message({
    required this.id,
    required this.text,
    required this.sender,
    required this.timestamp,
    this.status,
    this.type = 'text',
    this.fileUrl,
    this.fileName,
  });
}
