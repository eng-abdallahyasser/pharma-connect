class PharmacyModel {
  final String id;
  final String name;
  final String distance;
  final double rating;
  final String workingHours;
  final String imageUrl;
  final bool isOpen;
  final int totalDoctors;
  final int availableDoctors;

  PharmacyModel({
    required this.id,
    required this.name,
    required this.distance,
    required this.rating,
    required this.workingHours,
    required this.imageUrl,
    required this.isOpen,
    required this.totalDoctors,
    required this.availableDoctors,
  });
}
