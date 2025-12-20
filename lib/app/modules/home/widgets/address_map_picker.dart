import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class AddressMapPicker extends StatefulWidget {
  final LatLng initialPosition;
  final Function(LatLng) onPositionChanged;

  const AddressMapPicker({
    super.key,
    required this.initialPosition,
    required this.onPositionChanged,
  });

  @override
  State<AddressMapPicker> createState() => _AddressMapPickerState();
}

class _AddressMapPickerState extends State<AddressMapPicker> {
  late MapController _mapController;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: widget.initialPosition,
            initialZoom: 15.0,
            onPositionChanged: (position, hasGesture) {
              if (hasGesture) {
                setState(() {
                });
                widget.onPositionChanged(position.center);
              }
            },
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.abdallahyasser.pharma_connect',
            ),
          ],
        ),
        Center(
          child: Icon(
            Icons.location_on,
            size: 48,
            color: Theme.of(context).primaryColor,
          ),
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: () {
              _mapController.move(widget.initialPosition, 15.0);
              setState(() {
              });
              widget.onPositionChanged(widget.initialPosition);
            },
            child: Icon(
              Icons.my_location,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
