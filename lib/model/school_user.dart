class SchoolUser {
  int id;
  bool isTermed;
  int term;
  String name;
  String email;
  String schoolName;
  String phoneNumber;
  String? imageUrl;
  String noOfPupil;
  String country;
  String howDoYouSeeUs;
  String type;
  String countDown;
  Token token;

  SchoolUser({
    required this.id,
    required this.isTermed,
    required this.term,
    required this.name,
    required this.email,
    required this.schoolName,
    required this.phoneNumber,
    this.imageUrl,
    required this.noOfPupil,
    required this.country,
    required this.howDoYouSeeUs,
    required this.type,
    required this.countDown,
    required this.token,
  });

  factory SchoolUser.fromJson(Map<String, dynamic> json) {
    return SchoolUser(
      id: json['id'] ?? 0,
      isTermed: json['isTermed'] ?? false,
      term: json['term'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      schoolName: json['school_name'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      imageUrl: json['https://res.cloudinary.com/ddsxasrjb/image/upload/v1712218885/gnkispsdc7ydpr6wxfso.png'],
      noOfPupil: json['no_of_pupil'] ?? '',
      country: json['country'] ?? '',
      howDoYouSeeUs: json['how_do_you_see_us'] ?? '',
      type: json['type'] ?? '',
      countDown: json['count_down'] ?? '',
      token: Token.fromJson(json['token']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'isTermed': isTermed,
      'term': term,
      'name': name,
      'email': email,
      'school_name': schoolName,
      'phone_number': phoneNumber,
      'https://res.cloudinary.com/ddsxasrjb/image/upload/v1712218885/gnkispsdc7ydpr6wxfso.png': imageUrl,
      'no_of_pupil': noOfPupil,
      'country': country,
      'how_do_you_see_us': howDoYouSeeUs,
      'type': type,
      'count_down': countDown,
      'token': token.toJson(),
    };
  }
}

class Token {
  String token;

  Token({
    required this.token,
  });

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      token: json['token'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
    };
  }
}
