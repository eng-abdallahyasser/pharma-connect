import 'package:flutter/material.dart';

// Stats card showing rating, reviews, distance and status
class DoctorStatsCard extends StatelessWidget {
  final String rating;
  final int totalRaters;
  final String distance;
  final bool isOnline;

  const DoctorStatsCard({
    super.key,
    required this.rating,
    required this.totalRaters,
    required this.distance,
    required this.isOnline,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Rating stat
          _buildStat(
            context,
            icon: Icons.star_rounded,
            iconColor: const Color(0xFFFCD34D),
            value: rating,
            label: '$totalRaters reviews',
          ),

          // Divider
          _buildDivider(context),

          // Distance stat
          _buildStat(
            context,
            icon: Icons.location_on_outlined,
            iconColor: Theme.of(context).colorScheme.primary,
            value: distance.split(' ').first,
            label: 'km away',
          ),

          // Divider
          _buildDivider(context),

          // Response time stat
          _buildStat(
            context,
            icon: Icons.access_time_filled,
            iconColor: const Color(0xFF00C897),
            value: isOnline ? '~5' : '~30',
            label: 'min response',
          ),
        ],
      ),
    );
  }

  Widget _buildStat(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String value,
    required String label,
  }) {
    return Column(
      children: [
        // Icon with background
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: iconColor, size: 22),
        ),
        const SizedBox(height: 8),
        // Value
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 2),
        // Label
        Text(label, style: TextStyle(fontSize: 11, color: Colors.grey[500])),
      ],
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Container(width: 1, height: 50, color: Colors.grey[200]);
  }
}
