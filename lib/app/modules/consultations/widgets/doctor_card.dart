import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharma_connect/app/routes/app_routes.dart';
import '../models/doctor_model.dart';

// Doctor card widget displaying doctor information with action buttons
class DoctorCard extends StatelessWidget {
  final DoctorModel doctor;
  final VoidCallback? onChat;
  final VoidCallback? onCall;
  final VoidCallback? onBook;

  const DoctorCard({
    super.key,
    required this.doctor,
    this.onChat,
    this.onCall,
    this.onBook,
  });

  // Get status color based on doctor's availability
  Color _getStatusColor(BuildContext context) {
    switch (doctor.status) {
      case 'available':
        return Theme.of(context).colorScheme.secondary; // Green
      case 'busy':
        return Colors.amber; // Yellow
      case 'offline':
        return Theme.of(context).disabledColor;
      default:
        return Theme.of(context).disabledColor;
    }
  }

  // Get status text
  String _getStatusText() {
    switch (doctor.status) {
      case 'available':
        return 'Available';
      case 'busy':
        return 'Busy';
      case 'offline':
        return 'Offline';
      default:
        return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.doctorDetail, arguments: doctor),
      child: Container(
        // White card with rounded corners and shadow
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor.withAlpha(26),
              blurRadius: 4,
              spreadRadius: 0,
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Doctor info section with avatar
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Doctor avatar with status indicator
                Stack(
                  children: [
                    // Avatar container
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Theme.of(context).dividerColor,
                          width: 2,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(32),
                        child: doctor.imageUrl != null
                            ? Image.network(
                                doctor.imageUrl!,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  // Fallback avatar with initials
                                  return Container(
                                    color: Theme.of(context).dividerColor,
                                    child: Center(
                                      child: Text(
                                        doctor.initials,
                                        style: TextStyle(
                                          color: Theme.of(context).cardColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              )
                            : Container(
                                color: Theme.of(context).dividerColor,
                                child: Center(
                                  child: Text(
                                    doctor.initials,
                                    style: TextStyle(
                                      color: Theme.of(context).cardColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    ),

                    // Status indicator dot
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _getStatusColor(context),
                          border: Border.all(
                            color: Theme.of(context).cardColor,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 12),

                // Doctor information
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Doctor name
                      Text(
                        doctor.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),

                      // Specialization
                      Text(
                        doctor.specialization ?? 'General Physician',
                        style: const TextStyle(fontSize: 12),
                      ),
                      const SizedBox(height: 8),

                      // Status badge and rating
                      Row(
                        children: [
                          // Status badge
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: doctor.isAvailable
                                  ? Theme.of(context).primaryColor.withAlpha(26)
                                  : Theme.of(
                                      context,
                                    ).dividerColor.withAlpha(50),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              _getStatusText(),
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: doctor.isAvailable
                                    ? Theme.of(context).primaryColor
                                    : Theme.of(context).hintColor,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),

                          // Rating with star
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                size: 14,
                                color: Colors.amber,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                doctor.averageRating != 0
                                    ? doctor.rating.toString()
                                    : 'Be first to rate',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: doctor.averageRating != 0
                                      ? Theme.of(
                                          context,
                                        ).textTheme.bodyLarge?.color
                                      : Theme.of(context).hintColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Action buttons
            Row(
              children: [
                // Chat button
                Expanded(
                  child: OutlinedButton(
                    onPressed: doctor.isOffline ? null : onChat,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      side: BorderSide(color: Theme.of(context).dividerColor),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.message,
                          size: 16,
                          color: doctor.isOffline
                              ? Theme.of(context).disabledColor
                              : Theme.of(context).primaryColor,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Chat',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: doctor.isOffline
                                ? Theme.of(context).disabledColor
                                : Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),

                // Call button
                Expanded(
                  child: OutlinedButton(
                    onPressed: doctor.isOffline ? null : onCall,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      side: BorderSide(color: Theme.of(context).dividerColor),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.phone,
                          size: 16,
                          color: doctor.isOffline
                              ? Theme.of(context).disabledColor
                              : Theme.of(context).primaryColor,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Call',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: doctor.isOffline
                                ? Theme.of(context).disabledColor
                                : Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),

                // Book button
                Expanded(
                  child: ElevatedButton(
                    onPressed: onBook,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 16,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Book',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
