import 'package:flutter/material.dart';
import 'package:pharma_connect/app/modules/consultations/models/doctor_model.dart';

// Doctor header widget with avatar and basic info
class DoctorHeader extends StatelessWidget {
  final DoctorModel doctor;

  const DoctorHeader({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(26),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          // Avatar with online indicator
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              
              // Avatar container with gradient border
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.secondary,
                    ],
                  ),
                ),
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.surface,
                    border: Border.all(
                      color: Theme.of(context).colorScheme.surface,
                      width: 3,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: doctor.imageUrl != null
                        ? Image.network(
                            doctor.imageUrl!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return _buildAvatarFallback(context);
                            },
                          )
                        : _buildAvatarFallback(context),
                  ),
                ),
              ),
              // Online indicator
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: doctor.isOnline
                      ? const Color(0xFF00C897)
                      : Colors.grey[400],
                  border: Border.all(
                    color: Theme.of(context).colorScheme.surface,
                    width: 3,
                  ),
                ),
                child: doctor.isOnline
                    ? const Icon(Icons.check, size: 12, color: Colors.white)
                    : null,
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Doctor name
          Text(
            doctor.name,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 6),

          // Specialization
          Text(
            doctor.specialization ?? 'General Physician',
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 12),

          // Status badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: doctor.isOnline
                  ? const Color(0xFF00C897).withAlpha(26)
                  : Colors.grey[200],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: doctor.isOnline
                        ? const Color(0xFF00C897)
                        : Colors.grey[500],
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  doctor.isOnline ? 'Available Now' : 'Currently Offline',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: doctor.isOnline
                        ? const Color(0xFF00C897)
                        : Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarFallback(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primary.withAlpha(26),
      child: Center(
        child: Text(
          doctor.initials,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
