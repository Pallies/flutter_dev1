import 'dart:convert';

import 'package:first_app/models/place_location.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class LocationInput extends StatefulWidget {
  const LocationInput({super.key, required this.onLocationPicked});

  final void Function(PlaceLocation location) onLocationPicked;

  @override
  State<StatefulWidget> createState() {
    return _LocationInputState();
  }
}

class _LocationInputState extends State<LocationInput> {
  bool _isLocationServiceEnabled = false;
  bool _pickedLocation = false;
  PlaceLocation? _placeLocation;

  void _getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    setState(() {
      _isLocationServiceEnabled = true;
    });
    locationData = await location.getLocation();
    // print('Location: ${locationData.latitude}, ${locationData.longitude}');
    // final url = Uri.parse(
    //   'https://api-adresse.data.gouv.fr/reverse/?lon=${locationData.longitude}&lat=${locationData.latitude}',
    // );
    // http.get(url, headers: {'Content-Type': 'application/json'}) ;
    final url1 = Uri.parse('https://api-adresse.data.gouv.fr/reverse/?lon=2.2&lat=48.8');
    Response data = await http.get(url1, headers: {'Content-Type': 'application/json'});
    final Map<String, dynamic> responseData = jsonDecode(data.body);
    setState(() {
      _isLocationServiceEnabled = false;
    });
    if (responseData["features"].isEmpty ||
        locationData.latitude == null ||
        locationData.longitude == null) {
      return;
    }
    setState(() {
      _pickedLocation=true;
      _placeLocation = PlaceLocation(
        latitude: locationData.latitude!,
        longitude: locationData.longitude!,
        address: responseData["features"][0]['properties']['label'],
      );
    });
    widget.onLocationPicked(_placeLocation!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Text(
      'Location Input',
      style: Theme.of(
        context,
      ).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.onSurface),
    );
    if (_pickedLocation) {
      content = SizedBox(
        width: double.infinity,
        height: 250,
        child: FlutterMap(
          options: MapOptions(
            initialCenter: LatLng(_placeLocation!.latitude, _placeLocation!.longitude), // Londres
            initialZoom: 9.2,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.first_app',
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point: LatLng(_placeLocation!.latitude, _placeLocation!.longitude),
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
      );
    }
    if (_isLocationServiceEnabled) {
      content = const CircularProgressIndicator();
    }
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: Theme.of(context).colorScheme.primary.withAlpha(50),
            ),
          ),
          child: content,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: _getCurrentLocation,
              icon: const Icon(Icons.location_on),
              label: const Text('Current Location'),
            ),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.map),
              label: const Text('Select on Map'),
            ),
          ],
        ),
      ],
    );
  }
}
