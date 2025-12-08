import 'package:flutter/material.dart';
import '../../home/models/pharmacy_model.dart';

class PharmacyMapView extends StatefulWidget {
  final List<PharmacyModel> pharmacies;
  final Function(PharmacyModel)? onSelectPharmacy;

  const PharmacyMapView({
    Key? key,
    required this.pharmacies,
    this.onSelectPharmacy,
  }) : super(key: key);

  @override
  State<PharmacyMapView> createState() => _PharmacyMapViewState();
}

class _PharmacyMapViewState extends State<PharmacyMapView> {
  PharmacyModel? selectedPharmacy;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Map Background with Grid Pattern
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blue[50]!,
                Colors.green[50]!,
                Colors.blue[100]!,
              ],
            ),
          ),
          child: CustomPaint(
            painter: GridPatternPainter(),
            child: Container(),
          ),
        ),

        // Map Details - Roads and landmarks
        Positioned.fill(
          child: Stack(
            children: [
              // Horizontal roads
              Positioned(
                top: MediaQuery.of(context).size.height * 0.25,
                left: 0,
                right: 0,
                child: Container(
                  height: 8,
                  color: Colors.grey.withOpacity(0.3),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.5,
                left: 0,
                right: 0,
                child: Container(
                  height: 12,
                  color: Colors.grey.withOpacity(0.4),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.75,
                left: 0,
                right: 0,
                child: Container(
                  height: 8,
                  color: Colors.grey.withOpacity(0.3),
                ),
              ),

              // Vertical roads
              Positioned(
                top: 0,
                bottom: 0,
                left: MediaQuery.of(context).size.width * 0.33,
                child: Container(
                  width: 8,
                  color: Colors.grey.withOpacity(0.3),
                ),
              ),
              Positioned(
                top: 0,
                bottom: 0,
                left: MediaQuery.of(context).size.width * 0.67,
                child: Container(
                  width: 8,
                  color: Colors.grey.withOpacity(0.3),
                ),
              ),

              // Park area
              Positioned(
                top: MediaQuery.of(context).size.height * 0.2,
                left: MediaQuery.of(context).size.width * 0.1,
                child: Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),

              // Building blocks
              Positioned(
                top: MediaQuery.of(context).size.height * 0.35,
                left: MediaQuery.of(context).size.width * 0.45,
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.6,
                left: MediaQuery.of(context).size.width * 0.7,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ],
          ),
        ),

        // User Location (Center)
        Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A73E8),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
              // Pulse animation
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFF1A73E8).withOpacity(0.5),
                    width: 8,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Pharmacy Pins
        ...widget.pharmacies.map((pharmacy) {
          final positions = _getPharmacyPosition(pharmacy.id);
          return Positioned(
            top: positions['top'] as double,
            left: positions['left'] as double,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedPharmacy = pharmacy;
                });
                widget.onSelectPharmacy?.call(pharmacy);
              },
              child: AnimatedScale(
                scale: selectedPharmacy?.id == pharmacy.id ? 1.25 : 1.0,
                duration: const Duration(milliseconds: 200),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Pin circle
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: pharmacy.isOpen
                            ? const Color(0xFF00C897)
                            : Colors.grey[400],
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 8,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    // Pin pointer
                    Positioned(
                      top: 32,
                      child: CustomPaint(
                        painter: PinPointerPainter(
                          color: pharmacy.isOpen
                              ? const Color(0xFF00C897)
                              : Colors.grey[400]!,
                        ),
                      ),
                    ),
                    // Pulse for selected
                    if (selectedPharmacy?.id == pharmacy.id)
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFF00C897).withOpacity(0.5),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),

        // Map Controls (Top Right)
        Positioned(
          top: 16,
          right: 16,
          child: Column(
            children: [
              FloatingActionButton(
                mini: true,
                backgroundColor: Colors.white,
                onPressed: () {},
                child: const Icon(
                  Icons.navigation,
                  color: Color(0xFF1A73E8),
                ),
              ),
              const SizedBox(height: 8),
              FloatingActionButton(
                mini: true,
                backgroundColor: Colors.white,
                onPressed: () {},
                child: const Icon(
                  Icons.add,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              FloatingActionButton(
                mini: true,
                backgroundColor: Colors.white,
                onPressed: () {},
                child: const Icon(
                  Icons.remove,
                  color: Colors.black87,
                ),
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
          Icon(
            Icons.location_on,
            size: 16,
            color: color,
          )
        else
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
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
                        Icon(
                          Icons.star,
                          size: 14,
                          color: Colors.amber,
                        ),
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
                    'Get Directions',
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
                  child: const Text('Call Now'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Map<String, double> _getPharmacyPosition(int pharmacyId) {
    final screenSize = MediaQuery.of(context).size;
    final positions = {
      1: {'top': screenSize.height * 0.35, 'left': screenSize.width * 0.55},
      2: {'top': screenSize.height * 0.60, 'left': screenSize.width * 0.30},
      3: {'top': screenSize.height * 0.45, 'left': screenSize.width * 0.70},
      4: {'top': screenSize.height * 0.70, 'left': screenSize.width * 0.65},
      5: {'top': screenSize.height * 0.45, 'left': screenSize.width * 0.20},
    };
    return positions[pharmacyId] ?? {'top': 0.0, 'left': 0.0};
  }
}

class GridPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.withOpacity(0.2)
      ..strokeWidth = 0.5;

    const gridSize = 40.0;

    // Vertical lines
    for (double x = 0; x < size.width; x += gridSize) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    // Horizontal lines
    for (double y = 0; y < size.height; y += gridSize) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(GridPatternPainter oldDelegate) => false;
}

class PinPointerPainter extends CustomPainter {
  final Color color;

  PinPointerPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;

    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(-6, 8);
    path.lineTo(6, 8);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(PinPointerPainter oldDelegate) =>
      oldDelegate.color != color;
}
