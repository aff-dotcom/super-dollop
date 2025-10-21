// lib/screens/map/map_screen.dart
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../models/place.dart';
import '../../services/mock_data .dart';


class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  final Set<Marker> _markers = {};
  String? selectedPlaceId;

  @override
  void initState() {
    super.initState();
    _loadMarkers();
  }

  void _loadMarkers() {
    setState(() {
      _markers.clear();
      for (var place in MockData.places) {
        _markers.add(
          Marker(
            markerId: MarkerId(place.id),
            position: LatLng(place.latitude, place.longitude),
            onTap: () {
              setState(() {
                selectedPlaceId = place.id;
              });
            },
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final placeId = ModalRoute.of(context)!.settings.arguments as String?;
    if (placeId != null && selectedPlaceId != placeId) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          selectedPlaceId = placeId;
        });
      });
    }
    return Stack(
      children: [
        GoogleMap(
          onMapCreated: (controller) => mapController = controller,
          initialCameraPosition: const CameraPosition(
            target: LatLng(48.8566, 2.3522),
            zoom: 12,
          ),
          markers: _markers,
        ),
        // Barre de recherche
        Positioned(
          top: 50,
          left: 16,
          right: 16,
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFecbdea),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const TextField(
              decoration: InputDecoration(
                hintText: 'Rechercher un lieu...',
                prefixIcon: Icon(Icons.search, color: Colors.black87),
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(16),
                hintStyle: TextStyle(color: Colors.black87),
              ),
              style: TextStyle(color: Colors.black87),
            ),
          ),
        ),
        // Bouton pour ajouter un lieu
        Positioned(
          bottom: 20,
          right: 20,
          child: FloatingActionButton(
            backgroundColor: const Color(0xFFaf83b6),
            onPressed: () => Navigator.pushNamed(context, '/add-place'),
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
