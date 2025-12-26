import 'package:flutter/material.dart';
import '../models/doctor_detail_model.dart';

// Doctor card widget displaying doctor information
class DoctorCard extends StatelessWidget {
  final DoctorDetailModel doctor;
  final VoidCallback onBookPressed;
  final VoidCallback onChatPressed;
  final bool isPreview;

  const DoctorCard({
    super.key,
    required this.doctor,
    required this.onBookPressed,
    required this.onChatPressed,
    this.isPreview = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Doctor header
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar
              Container(
                width: isPreview ? 48 : 64,
                height: isPreview ? 48 : 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.grey[300]!,
                    width: 1,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(isPreview ? 24 : 32),
                  child: Image.network(
                    doctor.photo,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[300],
                        child: Center(
                          child: Text(
                            doctor.initials,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(width: 12),

              // Doctor info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name
                    Text(
                      doctor.name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1F2937),
                      ),
                    ),

                    const SizedBox(height: 2),

                    // Specialization
                    Text(
                      doctor.specialization,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),

                    if (!isPreview) ...[
                      const SizedBox(height: 4),

                      // Rating and experience
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 14,
                            color: Colors.amber[600],
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${doctor.rating}',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${doctor.experience} exp',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),

              // Availability badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: doctor.isAvailable
                      ? const Color(0xFF00C897).withOpacity(0.1)
                      : Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  doctor.availabilityStatus,
                  style: TextStyle(
                    fontSize: 11,
                    color: doctor.isAvailable
                        ? const Color(0xFF00C897)
                        : Colors.grey[600],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          if (!isPreview) ...[
            const SizedBox(height: 16),

            // Working hours and consultation fee
            Row(
              children: [
                // Working hours
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.schedule,
                              size: 14,
                              color: const Color(0xFF1A73E8),
                            ),
                            const SizedBox(width: 4),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Working Hours',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          doctor.workingHours,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1F2937),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                // Consultation fee
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.shopping_bag,
                              size: 14,
                              color: const Color(0xFF1A73E8),
                            ),
                            const SizedBox(width: 4),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Consultation',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          doctor.consultationFee,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1F2937),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Action buttons
            Row(
              children: [
                // Book appointment button
                Expanded(
                  child: OutlinedButton(
                    onPressed: doctor.isAvailable ? onBookPressed : null,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      side: BorderSide(
                        color: doctor.isAvailable
                            ? Colors.grey[300]!
                            : Colors.grey[200]!,
                      ),
                    ),
                    child: Text(
                      'Book Appointment',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: doctor.isAvailable
                            ? Colors.grey[700]
                            : Colors.grey[400],
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                // Chat button
                Expanded(
                  child: ElevatedButton(
                    onPressed: doctor.isAvailable ? onChatPressed : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: doctor.isAvailable
                          ? const Color(0xFF1A73E8)
                          : Colors.grey[300],
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Chat Now',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
