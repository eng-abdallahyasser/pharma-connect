import 'package:flutter/material.dart';
import '../models/consultation_model.dart';

// Consultation card widget displaying scheduled or past consultation details
class ConsultationCard extends StatelessWidget {
  final ConsultationModel consultation;
  final bool isPast; // Whether this is a past consultation
  final VoidCallback?
  onActionPressed; // For upcoming: join/call, for past: view prescription
  final VoidCallback? onReschedule;
  final VoidCallback? onCancel;

  const ConsultationCard({
    super.key,
    required this.consultation,
    this.isPast = false,
    this.onActionPressed,
    this.onReschedule,
    this.onCancel,
  });

  // Get status badge color
  Color _getStatusColor(BuildContext context) {
    if (isPast) {
      return Theme.of(context).disabledColor;
    }

    switch (consultation.status) {
      case 'confirmed':
        return Theme.of(context).colorScheme.secondary; // Green usually
      case 'pending':
        return Colors.amber; // Yellow
      default:
        return Theme.of(context).disabledColor;
    }
  }

  // Get consultation type icon
  IconData _getTypeIcon() {
    switch (consultation.type) {
      case 'Video Call':
        return Icons.videocam;
      case 'Chat':
        return Icons.message;
      case 'Phone Call':
        return Icons.phone;
      default:
        return Icons.call;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
          // Header with doctor info and status
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Doctor information
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Doctor name
                    Text(
                      consultation.doctorName,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Specialization
                    Text(
                      consultation.specialization,
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Date and time with icon
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 14,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          consultation.date,
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.color,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          consultation.time,
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.color,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Status badge (only for upcoming consultations)
              if (!isPast)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(context).withAlpha(26),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    consultation.status.toUpperCase(),
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: _getStatusColor(context),
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(height: 12),

          // Divider
          Container(height: 1, color: Theme.of(context).dividerColor),

          const SizedBox(height: 12),

          // Consultation type and action buttons
          if (!isPast)
            // Upcoming consultation - show type and action buttons
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Consultation type with icon
                Row(
                  children: [
                    Icon(
                      _getTypeIcon(),
                      size: 16,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      consultation.type,
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Action buttons
                Row(
                  children: [
                    // Join/Call button
                    Expanded(
                      child: ElevatedButton(
                        onPressed: onActionPressed,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              _getTypeIcon(),
                              size: 16,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              consultation.isVideoCall
                                  ? 'Join Call'
                                  : consultation.isChat
                                  ? 'Join Chat'
                                  : 'Call Now',
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
                    const SizedBox(width: 8),

                    // Reschedule button
                    Expanded(
                      child: OutlinedButton(
                        onPressed: onReschedule,
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          side: BorderSide(
                            color: Theme.of(context).dividerColor,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.edit,
                              size: 16,
                              color: Theme.of(context).hintColor,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Reschedule',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )
          else
            // Past consultation - show type and view prescription button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Consultation type with icon
                Row(
                  children: [
                    Icon(
                      _getTypeIcon(),
                      size: 16,
                      color: Theme.of(context).hintColor,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      consultation.type,
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).hintColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                // View prescription button (if applicable)
                if (consultation.hasPrescription)
                  GestureDetector(
                    onTap: onActionPressed,
                    child: Text(
                      'View Prescription',
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
