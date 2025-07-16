import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';

import '../widgets/merchant_bottom_sheet.dart';
import '../models/merchant.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  double? latitude;
  double? longitude;
  String? cityName;
  LatLng? _userLatLng;
  List<Merchant> _merchants = [];

  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    _getLocationAndCity();
  }

  Future<void> _getLocationAndCity() async {
    try {
      final pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      final lat = pos.latitude;
      final lon = pos.longitude;

      final city = await _getCityFromCoordinates(lat, lon);
      final fetchedMerchants = await fetchNearbyMerchants(lat, lon);

      setState(() {
        latitude = lat;
        longitude = lon;
        cityName = city ?? 'Unknown';
        _userLatLng = LatLng(lat, lon);
        _merchants = fetchedMerchants;
      });

      _mapController.move(_userLatLng!, 16.0);
    } catch (e) {
      print('❌ Error getting location: $e');
    }
  }

  Future<String?> _getCityFromCoordinates(double lat, double lon) async {
    final url = Uri.parse(
        'https://nominatim.openstreetmap.org/reverse?lat=$lat&lon=$lon&format=json');
    final headers = {
      'User-Agent': 'FusionCardsHackathonApp (your@email.com)',
    };

    try {
      final res = await http.get(url, headers: headers);
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        final address = data['address'];

        final parts = [
          address['city'] ?? address['town'] ?? address['village'],
          address['state'],
        ];

        return parts.where((e) => e != null).join(', ');
      }
    } catch (e) {
      print('🌐 Reverse geocoding error: $e');
    }
    return null;
  }

  Future<List<Merchant>> fetchNearbyMerchants(double latitude, double longitude) async {
    final url = Uri.parse(
      'https://places-api.foursquare.com/places/search'
          '?ll=$latitude,$longitude'
          '&radius=1000'
          '&fields=name,tel,location,categories,distance'
          '&sort=DISTANCE'
          '&limit=10',
    );

    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer 1HPQH2PHIPCFX35FPQUJIP2ZO3TD1GINGXWT3TNJ5DRZ5JVQ',
        'X-Places-Api-Version': '2025-06-17',
      },
    );

    debugPrint("📡 Fetching merchants from Foursquare...");
    debugPrint("📍 URL: $url");

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = data['results'] as List<dynamic>;

      return results.map((place) {
        final location = place['location'];
        final categories = place['categories'] as List<dynamic>;

        return Merchant(
          name: place['name'] ?? 'Unknown Place',
          category: categories.isNotEmpty ? categories[0]['name'] : 'Uncategorized',
          distance: place['distance'] ?? 0,
          address: location['formatted_address']?.toString().isNotEmpty == true
              ? location['formatted_address']
              : '${location['locality'] ?? ''}, ${location['region'] ?? ''}',
        );
      }).toList();
    } else {
      debugPrint('❌ Foursquare API Error ${response.statusCode}: ${response.body}');
      throw Exception('Failed to load merchants');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Nearby Merchants")),
      body: _userLatLng == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              center: _userLatLng,
              zoom: 15.0,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: ['a', 'b', 'c'],
                tileProvider: NetworkTileProvider(
                  headers: {
                    'User-Agent': 'FusionCardsHackathonApp (balajimchk@gmail.com)',
                  },
                ),
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: _userLatLng!,
                    builder: (ctx) => const Icon(
                      Icons.my_location,
                      color: Colors.blue,
                      size: 36,
                    ),
                  ),
                ],
              ),
            ],
          ),


          // Location info
          // Location info (City + State only)
          Positioned(
            top: 20,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  cityName ?? "Loading location...",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),


          // Bottom Sheet
          MerchantBottomSheet(merchants: _merchants),
        ],
      ),
    );
  }
}
