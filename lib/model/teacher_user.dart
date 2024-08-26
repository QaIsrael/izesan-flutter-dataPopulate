import 'dart:convert';

class School {
  final int id;
  final String name;
  final String email;
  final String type;
  final String country;
  final String schoolName;
  final String howDoYouSeeUs;
  final String phoneNumber;
  final String noOfPupil;
  final String? imageUrl;
  final String createdAt;
  final String updatedAt;
  final dynamic deletedAt;
  final String verificationToken;
  final dynamic deletedBy;
  final int status;
  final String state;
  final String lga;
  final int trialDays;
  final int hasActiveSub;
  final String address;
  final bool isTermed;
  final int term;
  final String lastLoginAt;

  School({
    required this.id,
    required this.name,
    required this.email,
    required this.type,
    required this.country,
    required this.schoolName,
    required this.howDoYouSeeUs,
    required this.phoneNumber,
    required this.noOfPupil,
    this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.verificationToken,
    required this.deletedBy,
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

  factory School.fromJson(Map<String, dynamic> json) {
    return School(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      type: json['type'] ?? '',
      country: json['country'] ?? '',
      schoolName: json['school_name'] ?? '',
      howDoYouSeeUs: json['how_do_you_see_us'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      noOfPupil: json['no_of_pupil'] ?? '',
      imageUrl: json['https://res.cloudinary.com/ddsxasrjb/image/upload/v1712218885/gnkispsdc7ydpr6wxfso.png'],
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
  final String token;

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

class TeacherUser {
  final int id;
  final String teacherId;
  final String createdAt;
  final String name;
  final String email;
  final School? school;
  final String address;
  final String imageUrl;
  final String countDown;
  final List<ClassInfo> classes;
  final bool surveyFilled;
  final bool midlineSurveyFilled;
  final bool canFillMidlineSurvey;
  final Token? token;

  TeacherUser({
    required this.id,
    required this.teacherId,
    required this.createdAt,
    required this.name,
    required this.email,
    this.school,
    required this.address,
    required this.imageUrl,
    required this.countDown,
    required this.classes,
    required this.surveyFilled,
    required this.midlineSurveyFilled,
    required this.canFillMidlineSurvey,
    this.token,
  });

  factory TeacherUser.fromJson(Map<String, dynamic> json) {
    List<ClassInfo> classes = [];
    if (json['classes'] != null) {
      classes = (json['classes'] as List<dynamic>)
          .map((classData) => ClassInfo.fromJson(classData))
          .toList();
    }

    return TeacherUser(
      id: json['id'] ?? 0,
      teacherId: json['teacher_id'] ?? '',
      createdAt: json['created_at'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      school: json['school'] != null ? School.fromJson(json['school']) : null,
      address: json['address'] ?? '',
      imageUrl: json['https://course-material-dev.s3.us-east-2.amazonaws.com/images/pve2zd3QscUinIQ.png'] ?? '',
      countDown: json['count_down'] ?? '',
      classes: classes,
      surveyFilled: json['surveyFilled'] ?? false,
      midlineSurveyFilled: json['midlineSurveyFilled'] ?? false,
      canFillMidlineSurvey: json['canFillMidlineSurvey'] ?? false,
      token: json['token'] != null ? Token.fromJson(json['token']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'teacher_id': teacherId,
      'created_at': createdAt,
      'name': name,
      'email': email,
      'school': school?.toJson(),
      'address': address,
      'imageUrl': imageUrl,
      'count_down': countDown,
      'classes': classes.map((classInfo) => classInfo.toJson()).toList(),
      'surveyFilled': surveyFilled,
      'midlineSurveyFilled': midlineSurveyFilled,
      'canFillMidlineSurvey': canFillMidlineSurvey,
      'token': token?.toJson(),
    };
  }
}

class ClassInfo {
  final String fullName;
  final String name;

  ClassInfo({
    required this.fullName,
    required this.name,
  });

  factory ClassInfo.fromJson(Map<String, dynamic> json) {
    return ClassInfo(
      fullName: json['fullName'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'name': name,
    };
  }
}