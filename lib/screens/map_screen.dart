import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../models/place_location.model.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    super.key,
    this.location = const PlaceLocation(latitude: 48.8566, longitude: 2.3522, address: ''),
    this.isSelecting = true,
  });

  final PlaceLocation location;
  final bool isSelecting;

  @override
  State<StatefulWidget> createState() {
    return _MapScreenState();
  }
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isSelecting ? 'Pick your location' : 'Your Location'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Center(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: FlutterMap(
            mapController: MapController(

            ),
            options: MapOptions(
              initialCenter: LatLng(widget.location.latitude, widget.location.longitude), // Londres
              initialZoom: 16,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png?key=APIKEY&style=contrast-',
                userAgentPackageName: 'com.example.first_app',
              ),//https://tile.tracestrack.com/topo_fr/{z}/{x}/{y}.png?key=APIKEY&style=contrast-
              MarkerLayer(
                markers: [
                  Marker(
                    point: LatLng(widget.location.latitude, widget.location.longitude),
                    width: 80,
                    height: 80,
                    child: Icon(
                      Icons.location_on,
                      size: 46,
                      color: Colors.red.shade700,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
