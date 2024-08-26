class StudentUser {
  int id;
  String username;
  String lastName;
  String studentId;
  String language;
  String gender;
  School? school; // Make school nullable
  String? classType;
  String? classLanguage;
  String? ourClass;
  String? classArm;
  int? age;
  String? country;
  String? countDown;
  String? createdAt;
  bool? surveyFilled;
  bool? midlineSurveyFilled;
  bool? canFillMidlineSurvey;
  bool? isGuest;
  Token? token; // Make token nullable

  StudentUser({
    required this.id,
    required this.username,
    required this.lastName,
    required this.studentId,
    required this.language,
    required this.gender,
    this.school,
    this.classType,
    this.classLanguage,
    this.ourClass,
    this.classArm,
    this.age,
    this.country,
    this.countDown,
    this.createdAt,
    this.surveyFilled,
    this.midlineSurveyFilled,
    this.canFillMidlineSurvey,
    this.isGuest,
    this.token,
  });

  factory StudentUser.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw FormatException("Null JSON provided to StudentUser");
    }

    return StudentUser(
      id: json['id'] ?? 0, // Provide a default value or handle null appropriately
      username: json['username'] ?? '',
      lastName: json['last_name'] ?? '',
      studentId: json['student_id'] ?? '',
      language: json['language'] ?? '',
      gender: json['gendar'] ?? '',
      school: json['school'] != null ? School.fromJson(json['school']) : null,
      classType: json['class'],
      classLanguage: json['classLanguage'],
      ourClass: json['ourClass'],
      classArm: json['classarm'],
      age: json['age'],
      country: json['country'],
      countDown: json['count_down'],
      createdAt: json['created_at'],
      surveyFilled: json['surveyFilled'],
      midlineSurveyFilled: json['midlineSurveyFilled'],
      canFillMidlineSurvey: json['canFillMidlineSurvey'],
      isGuest: json['isGuest'],
      token: json['token'] != null ? Token.fromJson(json['token']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'last_name': lastName,
      'student_id': studentId,
      'language': language,
      'gendar': gender,
      'school': school?.toJson(),
      'class': classType,
      'classLanguage': classLanguage,
      'ourClass': ourClass,
      'classarm': classArm,
      'age': age,
      'country': country,
      'count_down': countDown,
      'created_at': createdAt,
      'surveyFilled': surveyFilled,
      'midlineSurveyFilled': midlineSurveyFilled,
      'canFillMidlineSurvey': canFillMidlineSurvey,
      'isGuest': isGuest,
      'token': token?.toJson(),
    };
  }
}

class School {
  int id;
  String name;
  String email;
  String? emailVerifiedAt;
  String type;
  String country;
  String schoolName;
  String howDoYouSeeUs;
  String phoneNumber;
  String noOfPupil;
  String? imageUrl;
  String createdAt;
  String updatedAt;
  String? deletedAt;
  String verificationToken;
  String? deletedBy;
  int status;
  String state;
  String lga;
  int trialDays;
  int hasActiveSub;
  String address;
  bool isTermed;
  int term;
  String lastLoginAt;

  School({
    required this.id,
    required this.name,
    required this.email,
    this.emailVerifiedAt,
    required this.type,
    required this.country,
    required this.schoolName,
    required this.howDoYouSeeUs,
    required this.phoneNumber,
    required this.noOfPupil,
    this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.verificationToken,
    this.deletedBy,
    required this.status,
    required this.state,
    required this.lga,
    required this.trialDays,
    required this.hasActiveSub,
    required this.address,
    required this.isTermed,
    required this.term,
    required this.lastLoginAt,
  });

  factory School.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw FormatException("Null JSON provided to School");
    }

    return School(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      emailVerifiedAt: json['email_verified_at'],
      type: json['type'] ?? '',
      country: json['country'] ?? '',
      schoolName: json['school_name'] ?? '',
      howDoYouSeeUs: json['how_do_you_see_us'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      noOfPupil: json['no_of_pupil'] ?? '',
      imageUrl: json['https://res.cloudinary.com/ddsxasrjb/image/upload/v1712218885/gnkispsdc7ydpr6wxfso.png'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      deletedAt: json['deleted_at'],
      verificationToken: json['verification_token'] ?? '',
      deletedBy: json['deleted_by'],
      status: json['status'] ?? 0,
      state: json['state'] ?? '',
      lga: json['lga'] ?? '',
      trialDays: json['trial_days'] ?? 0,
      hasActiveSub: json['hasActiveSub'] ?? 0,
      address: json['address'] ?? '',
      isTermed: json['isTermed'] ?? false,
      term: json['term'] ?? 0,
      lastLoginAt: json['last_login_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'email_verified_at': emailVerifiedAt,
      'type': type,
      'country': country,
      'school_name': schoolName,
      'how_do_you_see_us': howDoYouSeeUs,
      'phone_number': phoneNumber,
      'no_of_pupil': noOfPupil,
      'https://res.cloudinary.com/ddsxasrjb/image/upload/v1712218885/gnkispsdc7ydpr6wxfso.png': imageUrl,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
      'verification_token': verificationToken,
      'deleted_by': deletedBy,
      'status': status,
      'state': state,
      'lga': lga,
      'trial_days': trialDays,
      'hasActiveSub': hasActiveSub,
      'address': address,
      'isTermed': isTermed,
      'term': term,
      'last_login_at': lastLoginAt,
    };
  }
}

class Token {
  String token;

  Token({
    required this.token,
  });

  factory Token.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw FormatException("Null JSON provided to Token");
    }

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
