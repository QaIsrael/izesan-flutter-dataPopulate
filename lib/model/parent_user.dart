class ParentUser {
  final String id;
  final String name;
  final String email;
  // Add other fields here

  ParentUser({
    required this.id,
    required this.name,
    required this.email,
    // Initialize other fields here
  });

  // Factory constructor to create a SchoolUser from a JSON map
  factory ParentUser.fromJson(Map<String, dynamic> json) {
    return ParentUser(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      // Parse other fields here
    );
  }

  // Method to convert a SchoolUser instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      // Add other fields here
    };
  }
}
