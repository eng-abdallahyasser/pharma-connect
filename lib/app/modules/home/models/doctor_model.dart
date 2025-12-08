class DoctorModel {
  final int id;
  final String name;
  final String specialization;
  final String imageUrl;
  final double rating;
  final String status; // available, busy, offline

  DoctorModel({
    required this.id,
    required this.name,
    required this.specialization,
    required this.imageUrl,
    required this.rating,
    required this.status,
  });
}
