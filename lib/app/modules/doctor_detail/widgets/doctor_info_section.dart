import 'package:flutter/material.dart';
import 'package:pharma_connect/app/modules/consultations/models/doctor_model.dart';

// Doctor information section with about and location details
class DoctorInfoSection extends StatelessWidget {
  final DoctorModel doctor;

  const DoctorInfoSection({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // About section
        _buildSectionHeader(context, 'About Doctor', Icons.person_outline),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey[200]!, width: 1),
          ),
          child: Text(
            _getAboutText(),
            style: TextStyle(
              fontSize: 14,
              height: 1.6,
              color: Colors.grey[700],
            ),
          ),
        ),

        const SizedBox(height: 20),

        // Location section
        _buildSectionHeader(context, 'Location', Icons.location_on_outlined),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey[200]!, width: 1),
          ),
          child: Row(
            children: [
              // Map placeholder
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(
                      Icons.map_outlined,
                      size: 36,
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withOpacity(0.3),
                    ),
                    Icon(
                      Icons.location_on,
                      size: 28,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Medical Center',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _getLocationText(),
                      style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.directions_walk,
                          size: 16,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${doctor.distance.toStringAsFixed(1)} km away',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Direction button
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.directions,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // Working hours section
        _buildSectionHeader(context, 'Working Hours', Icons.schedule_outlined),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey[200]!, width: 1),
          ),
          child: Column(
            children: [
              _buildWorkingHoursRow(
                'Monday - Friday',
                '9:00 AM - 5:00 PM',
                true,
              ),
              const Divider(height: 16),
              _buildWorkingHoursRow('Saturday', '10:00 AM - 2:00 PM', true),
              const Divider(height: 16),
              _buildWorkingHoursRow('Sunday', 'Closed', false),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(
    BuildContext context,
    String title,
    IconData icon,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 18,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildWorkingHoursRow(String day, String hours, bool isOpen) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          day,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isOpen ? const Color(0xFF00C897) : Colors.grey[400],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              hours,
              style: TextStyle(
                fontSize: 14,
                color: isOpen ? Colors.grey[700] : Colors.grey[500],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _getAboutText() {
    return '${doctor.name} is an experienced ${doctor.specialization ?? 'General Physician'} with extensive expertise in patient care. '
        'They are dedicated to providing the highest quality healthcare services and have received excellent ratings from patients.';
  }

  String _getLocationText() {
    return 'Branch ID: ${doctor.branch.id.substring(0, 8)}...';
  }
}
