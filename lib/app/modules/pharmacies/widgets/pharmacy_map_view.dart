import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../home/models/pharmacy_model.dart';

class PharmacyMapView extends StatefulWidget {
  final List<PharmacyModel> pharmacies;
  final Map<int, LatLng>? pharmacyLocations;
  final Function(PharmacyModel)? onSelectPharmacy;
  final LatLng? userLocation;

  const PharmacyMapView({
    super.key,
    required this.pharmacies,
    this.pharmacyLocations,
    this.onSelectPharmacy,
    this.userLocation,
  });

  @override
  State<PharmacyMapView> createState() => _PharmacyMapViewState();
}

class _PharmacyMapViewState extends State<PharmacyMapView> {
  PharmacyModel? selectedPharmacy;
  final MapController _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter:
                widget.userLocation ??
                (widget.pharmacyLocations?.isNotEmpty == true
                    ? widget.pharmacyLocations!.values.first
                    : const LatLng(30.0444, 31.2357)), // Default to Cairo
            initialZoom: 13.0,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.pharma_connect.app',
            ),
            MarkerLayer(
              markers: widget.pharmacies
                  .map((pharmacy) {
                    final latlng = widget.pharmacyLocations?[pharmacy.id];
                    if (latlng == null) return null;

                    return Marker(
                      point: latlng,
                      width: 50,
                      height: 50,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedPharmacy = pharmacy;
                          });
                          widget.onSelectPharmacy?.call(pharmacy);
                        },
                        child: AnimatedScale(
                          scale: selectedPharmacy?.id == pharmacy.id
                              ? 1.25
                              : 1.0,
                          duration: const Duration(milliseconds: 200),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 40,
                                color: pharmacy.isOpen
                                    ? const Color(0xFF00C897)
                                    : Colors.grey[400],
                              ),
                              if (selectedPharmacy?.id == pharmacy.id)
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: const Color(
                                      0xFF00C897,
                                    ).withAlpha(75),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  })
                  .whereType<Marker>()
                  .toList(),
            ),
          ],
        ),

        // Map Controls (Top Right)
        Positioned(
          top: 16,
          right: 16,
          child: Column(
            children: [
              FloatingActionButton(
                heroTag: 'zoom_in',
                mini: true,
                backgroundColor: Colors.white,
                onPressed: () {
                  _mapController.move(
                    _mapController.camera.center,
                    _mapController.camera.zoom + 1,
                  );
                },
                child: const Icon(Icons.add, color: Colors.black87),
              ),
              const SizedBox(height: 8),
              FloatingActionButton(
                heroTag: 'zoom_out',
                mini: true,
                backgroundColor: Colors.white,
                onPressed: () {
                  _mapController.move(
                    _mapController.camera.center,
                    _mapController.camera.zoom - 1,
                  );
                },
                child: const Icon(Icons.remove, color: Colors.black87),
              ),
            ],
          ),
        ),

        // Legend (Top Left)
        Positioned(
          top: 16,
          left: 16,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  spreadRadius: 2,
                ),
              ],
            ),
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLegendItem(
                  color: const Color(0xFF1A73E8),
                  label: 'Your Location',
                ),
                const SizedBox(height: 8),
                _buildLegendItem(
                  color: const Color(0xFF00C897),
                  label: 'Open Pharmacy',
                  isPin: true,
                ),
                const SizedBox(height: 8),
                _buildLegendItem(
                  color: Colors.grey[400]!,
                  label: 'Closed Pharmacy',
                  isPin: true,
                ),
              ],
            ),
          ),
        ),

        // Selected Pharmacy Info Card (Bottom)
        if (selectedPharmacy != null)
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: _buildPharmacyInfoCard(selectedPharmacy!),
          ),
      ],
    );
  }

  Widget _buildLegendItem({
    required Color color,
    required String label,
    bool isPin = false,
  }) {
    return Row(
      children: [
        if (isPin)
          Icon(Icons.location_on, size: 16, color: color)
        else
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildPharmacyInfoCard(PharmacyModel pharmacy) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 12,
            spreadRadius: 2,
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            pharmacy.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: pharmacy.isOpen
                                ? const Color(0xFF00C897)
                                : Colors.grey[400],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            pharmacy.isOpen ? 'Open' : 'Closed',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 14,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          pharmacy.distance,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Icon(Icons.star, size: 14, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text(
                          pharmacy.rating.toString(),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Icon(
                          Icons.access_time,
                          size: 14,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            pharmacy.workingHours,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedPharmacy = null;
                  });
                },
                child: const Icon(Icons.close, size: 20),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A73E8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Call Now',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('View Details'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
