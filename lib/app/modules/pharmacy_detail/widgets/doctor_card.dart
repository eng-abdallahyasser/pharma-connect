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
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withAlpha(13),
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
                    color: Theme.of(context).dividerColor,
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
                        color: Theme.of(context).disabledColor,
                        child: Center(
                          child: Text(
                            doctor.initials,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
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
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).textTheme.titleLarge?.color,
                      ),
                    ),

                    const SizedBox(height: 2),

                    // Specialization
                    Text(
                      doctor.specialization,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                    ),

                    if (!isPreview) ...[
                      const SizedBox(height: 4),

                      // Rating and experience
                      Row(
                        children: [
                          Icon(Icons.star, size: 14, color: Colors.amber),
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
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).textTheme.bodyMedium?.color,
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
                      ? Theme.of(context).colorScheme.secondary.withAlpha(26)
                      : Theme.of(context).disabledColor.withAlpha(50),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  doctor.availabilityStatus,
                  style: TextStyle(
                    fontSize: 11,
                    color: doctor.isAvailable
                        ? Theme.of(context).colorScheme.secondary
                        : Theme.of(context).disabledColor,
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
                      color: Theme.of(context).scaffoldBackgroundColor,
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
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(width: 4),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Working Hours',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          doctor.workingHours,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(
                                  context,
                                ).textTheme.titleLarge?.color,
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
                      color: Theme.of(context).scaffoldBackgroundColor,
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
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(width: 4),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Consultation',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          doctor.consultationFee,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(
                                  context,
                                ).textTheme.titleLarge?.color,
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
                            ? Theme.of(context).dividerColor
                            : Theme.of(context).disabledColor.withAlpha(50),
                      ),
                    ),
                    child: Text(
                      'Book Appointment',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: doctor.isAvailable
                            ? Theme.of(context).textTheme.bodyMedium?.color
                            : Theme.of(context).disabledColor,
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
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).disabledColor,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Chat Now',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onPrimary,
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
