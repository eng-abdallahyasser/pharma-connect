import 'package:flutter/material.dart';
import '../models/pharmacy_detail_model.dart';

// Pharmacy header widget with image and basic info
class PharmacyHeader extends StatelessWidget {
  final PharmacyDetailModel pharmacy;
  final VoidCallback onBackPressed;
  final VoidCallback onSharePressed;

  const PharmacyHeader({
    Key? key,
    required this.pharmacy,
    required this.onBackPressed,
    required this.onSharePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Header image
        Container(
          height: 256,
          decoration: BoxDecoration(
            color: Colors.grey[300],
          ),
          child: Image.network(
            pharmacy.imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey[300],
                child: const Center(
                  child: Icon(
                    Icons.image_not_supported,
                    size: 48,
                    color: Colors.grey,
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
                Colors.black.withOpacity(0.6),
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
                color: Colors.white.withOpacity(0.9),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Icon(
                Icons.arrow_back,
                color: Colors.grey[800],
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
                color: Colors.white.withOpacity(0.9),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Icon(
                Icons.share,
                color: Colors.grey[800],
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
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: pharmacy.isOpen
                    ? const Color(0xFF00C897)
                    : const Color(0xFFEF4444),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                pharmacy.isOpen ? 'Open Now' : 'Closed',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white,
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
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 8),

              // Rating and distance
              Row(
                children: [
                  // Rating
                  Icon(
                    Icons.star,
                    size: 16,
                    color: Colors.amber[300],
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${pharmacy.rating}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(width: 12),

                  // Distance
                  Icon(
                    Icons.location_on,
                    size: 16,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${pharmacy.distance} away',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
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
