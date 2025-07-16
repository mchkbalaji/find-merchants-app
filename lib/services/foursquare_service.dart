import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class FoursquareService {
  static final _apiKey = dotenv.env['FOURSQUARE_API_KEY']!;
  static const _baseUrl = 'https://api.foursquare.com/v3/places/search';

  /// Fetches nearby places for given latitude & longitude.
  static Future<void> fetchNearby(double lat, double lng) async {
    final uri = Uri.parse('$_baseUrl?ll=$lat,$lng&radius=1000&limit=5');
    final response = await http.get(
      uri,
      headers: {
        'Authorization': _apiKey,
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('✅ Foursquare response: ${json.encode(data['results'])}');
    } else {
      print('❌ Error ${response.statusCode}: ${response.body}');
    }
  }
}
