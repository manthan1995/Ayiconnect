UserModel userModelFromJson(Map<String, dynamic> user) =>
    UserModel.fromJson(user);

class UserModel {
  UserModel({
    this.userId,
    this.profileUrl = "",
    this.fullName = "",
    this.gender = const [],
    this.dateOfBirth,
    this.phoneNumber = "",
    this.location = "",
    this.occupation = "",
    this.company = "",
    this.language = const [],
    this.preferedService = const [],
    this.description = "",
  });

  int? userId;
  String profileUrl;
  String fullName;
  List<GenderModel> gender;
  DateTime? dateOfBirth;
  String phoneNumber;
  String location;
  String occupation;
  String company;
  List<LanguageModel> language;
  List<LanguageModel> preferedService;
  String description;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userId: json["user_id"],
        profileUrl: json["profile_url"],
        fullName: json["full_name"],
        gender: List<GenderModel>.from(
          json["gender"].map(
            (x) => GenderModel.fromJson(x),
          ),
        ),
        phoneNumber: json["phone_number"],
        location: json["location"],
        occupation: json["occupation"],
        company: json["company"],
        language: List<LanguageModel>.from(
          json["language"].map(
            (x) => LanguageModel.fromJson(x),
          ),
        ),
        preferedService: List<LanguageModel>.from(
          json["prefered_service"].map(
            (x) => LanguageModel.fromJson(x),
          ),
        ),
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "profile_url": profileUrl,
        "full_name": fullName,
        "gender": List<dynamic>.from(gender.map((x) => x.toJson())),
        "date_of_birth": dateOfBirth,
        "phone_number": phoneNumber,
        "location": location,
        "occupation": occupation,
        "company": company,
        "language": List<dynamic>.from(language.map((x) => x.toJson())),
        "prefered_service":
            List<dynamic>.from(preferedService.map((x) => x.toJson())),
        "description": description,
      };
}

class GenderModel {
  GenderModel({
    this.gender = "",
    this.id = 0,
    this.isSelected = false,
  });

  String gender;
  int id;
  bool isSelected;

  factory GenderModel.fromJson(Map<String, dynamic> json) => GenderModel(
        gender: json["gender"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "gender": gender,
        "id": id,
      };
}

class LanguageModel {
  LanguageModel({
    this.name = "",
    this.id = 0,
    this.isSelected = false,
  });

  String name;
  int id;
  bool isSelected;

  factory LanguageModel.fromJson(Map<String, dynamic> json) => LanguageModel(
        name: json["name"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
      };
}

class PreferenceServiceModel {
  PreferenceServiceModel({
    this.name = "",
    this.id = 0,
    this.isSelected = false,
  });

  String name;
  int id;
  bool isSelected;

  factory PreferenceServiceModel.fromJson(Map<String, dynamic> json) =>
      PreferenceServiceModel(
        name: json["name"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
      };
}

UserModel get getDefaultUserInfo => userModelFromJson(
      {
        "user_id": 1,
        "profile_url": "",
        "full_name": "",
        "gender": [
          {
            "gender": "Male",
            "id": 1,
          },
          {
            "gender": "Female",
            "id": 2,
          },
          {
            "gender": "Others",
            "id": 3,
          }
        ],
        "date_of_birth": "",
        "phone_number": "",
        "location": "",
        "occupation": "",
        "company": "",
        "language": [
          {
            "name": "Spanish",
            "id": 1,
          },
          {
            "name": "Mandarin",
            "id": 2,
          },
          {
            "name": "English",
            "id": 3,
          }
        ],
        "prefered_service": [
          {
            "name": "Child Care",
            "id": 1,
          },
          {
            "name": "Senior Care",
            "id": 2,
          },
          {
            "name": "Home Care",
            "id": 3,
          },
          {
            "name": "Other Services",
            "id": 4,
          }
        ],
        "description": ""
      },
    );
