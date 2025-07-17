class Merchant {
  final String name;
  final String category;
  final int distance;
  final String address;
  final double? latitude;
  final double? longitude;

  Merchant({
    required this.name,
    required this.category,
    required this.distance,
    required this.address,
    this.latitude,
    this.longitude,
  });
}
