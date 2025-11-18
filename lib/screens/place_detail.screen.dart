import 'package:flutter/material.dart';

import '../models/place.model.dart';



class PlaceDetailScreen extends StatelessWidget {
  const PlaceDetailScreen({super.key, required this.place});

  final Place place;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body:  Stack(
        children: [
          Image.file(place.image,
            width: double.infinity,
            height: 250,
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: Container(
              color: Colors.black54,
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: Text(
                place.title,
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      )
    );
  }
}
