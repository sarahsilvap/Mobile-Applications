class Destination {
  final int id;
  final String name;
  final String image;
  final double valord;
  final double valorp;

  Destination({
    required this.id,
    required this.name,
    required this.image,
    required this.valord,
    required this.valorp,
  });

  factory Destination.fromJson(Map<String, dynamic> json) {
    return Destination(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      image: json['image'] as String,
      valord: (json['valord'] as num).toDouble(),
      valorp: (json['valorp'] as num).toDouble(),
    );
  }
}
