class Country {
  final String name;
  final List<NetworkChip> networkChips;

  Country({
    required this.name,
    required this.networkChips,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name'],
      networkChips: (json['network_chips'] as List)
          .map((chipJson) => NetworkChip.fromJson(chipJson))
          .toList(),
    );
  }
}

class NetworkChip {
  final String name;
  final String price;
  final List<String> privileges;
  final List<String> features;

  NetworkChip({
    required this.name,
    required this.price,
    required this.privileges,
    required this.features,
  });

  factory NetworkChip.fromJson(Map<String, dynamic> json) {
    return NetworkChip(
      name: json['name'],
      price: json['price'],
      privileges: (json['privileges'] as List).cast<String>(),
      features: (json['features'] as List).cast<String>(),
    );
  }
}
