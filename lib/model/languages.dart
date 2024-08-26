class Languages {
  final int id;
  final String name;
  final String imageUrl;
  final int status;

  Languages({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.status,
  });

  factory Languages.fromJson(Map<String, dynamic> json) {
    return Languages(
      id: json['id'],
      name: json['name'],
      imageUrl: json['image_url'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image_url': imageUrl,
      'status': status,
    };
  }
}
