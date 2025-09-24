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
      id: int.tryParse(json['id'].toString()) ?? 0,
      name: json['name'].toString(),
      image: json['image'].toString(),
      valord: double.tryParse(json['valord'].toString()) ?? 0.0,
      valorp: double.tryParse(json['valorp'].toString()) ?? 0.0,
    );
  }
}

