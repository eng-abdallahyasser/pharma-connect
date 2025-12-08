import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/health_tip_model.dart';

class HealthTipCard extends StatelessWidget {
  final HealthTipModel tip;
  final VoidCallback? onTap;

  const HealthTipCard({Key? key, required this.tip, this.onTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              // Background Image
              CachedNetworkImage(
                imageUrl: tip.imageUrl,
                width: 280,
                height: 160,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    Container(width: 280, height: 160, color: Colors.grey[300]),
                errorWidget: (context, url, error) => Container(
                  width: 280,
                  height: 160,
                  color: Colors.grey[300],
                  child: const Icon(Icons.image),
                ),
              ),
              // Gradient Overlay
              Container(
                width: 280,
                height: 160,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                  ),
                ),
              ),
              // Content
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tip.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        tip.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
