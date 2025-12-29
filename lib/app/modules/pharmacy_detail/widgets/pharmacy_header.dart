import 'package:flutter/material.dart';
import '../models/pharmacy_detail_model.dart';

// Pharmacy header widget with image and basic info
class PharmacyHeader extends StatelessWidget {
  final PharmacyDetailModel pharmacy;
  final VoidCallback onBackPressed;
  final VoidCallback onSharePressed;

  const PharmacyHeader({
    super.key,
    required this.pharmacy,
    required this.onBackPressed,
    required this.onSharePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Header image
        Container(
          height: 256,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceVariant,
          ),
          child: Image.network(
            pharmacy.imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Theme.of(context).colorScheme.surfaceVariant,
                child: Center(
                  child: Icon(
                    Icons.image_not_supported,
                    size: 48,
                    color: Theme.of(context).disabledColor,
                  ),
                ),
              );
            },
          ),
        ),

        // Gradient overlay
        Container(
          height: 256,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Theme.of(context).shadowColor.withAlpha(128),
              ],
            ),
          ),
        ),

        // Back button
        Positioned(
          top: 24,
          left: 16,
          child: GestureDetector(
            onTap: onBackPressed,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface.withAlpha(220),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).shadowColor.withAlpha(51),
                    blurRadius: 8,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Icon(
                Icons.arrow_back,
                color: Theme.of(context).colorScheme.onSurface,
                size: 20,
              ),
            ),
          ),
        ),

        // Share button
        Positioned(
          top: 24,
          right: 16,
          child: GestureDetector(
            onTap: onSharePressed,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface.withAlpha(220),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).shadowColor.withAlpha(51),
                    blurRadius: 8,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Icon(
                Icons.share,
                color: Theme.of(context).colorScheme.onSurface,
                size: 20,
              ),
            ),
          ),
        ),

        // Status badge
        Positioned(
          top: 24,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: pharmacy.isOpen
                    ? Theme.of(context).colorScheme.secondary
                    : Theme.of(context).colorScheme.error,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                pharmacy.isOpen ? 'Open Now' : 'Closed',
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.onSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),

        // Pharmacy info at bottom
        Positioned(
          bottom: 16,
          left: 16,
          right: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Pharmacy name
              Text(
                pharmacy.name,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 8),

              // Rating and distance
              Row(
                children: [
                  // Rating
                  Icon(Icons.star, size: 16, color: Colors.amber[300]),
                  const SizedBox(width: 4),
                  Text(
                    '${pharmacy.rating}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(width: 12),

                  // Distance
                  Icon(Icons.location_on, size: 16, color: Colors.white),
                  const SizedBox(width: 4),
                  Text(
                    '${pharmacy.distance} away',
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
