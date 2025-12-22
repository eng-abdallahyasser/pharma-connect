class UserPreferences {
  final String language;
  final bool pushNotificationsEnabled;
  final bool emailNotificationsEnabled;

  UserPreferences({
    required this.language,
    required this.pushNotificationsEnabled,
    required this.emailNotificationsEnabled,
  });

  factory UserPreferences.fromJson(Map<String, dynamic> json) {
    return UserPreferences(
      language: json['language'] as String? ?? 'en',
      pushNotificationsEnabled:
          json['pushNotificationsEnabled'] as bool? ?? true,
      emailNotificationsEnabled:
          json['emailNotificationsEnabled'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'language': language,
      'pushNotificationsEnabled': pushNotificationsEnabled,
      'emailNotificationsEnabled': emailNotificationsEnabled,
    };
  }
}

class UserMetadata {
  final DateTime? createdAt;
  final int? version;

  UserMetadata({this.createdAt, this.version});

  factory UserMetadata.fromJson(Map<String, dynamic> json) {
    return UserMetadata(
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      version: json['version'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (createdAt != null) 'createdAt': createdAt?.toIso8601String(),
      if (version != null) 'version': version,
    };
  }
}

class User {
  final String id;
  final String email;
  final DateTime? birthDate;
  final String? mobile;
  final String? countryCode;
  final bool mobileVerified;
  final bool emailVerified;
  final bool idVerified;
  final String? code;
  final int identityConfirmedTrials;
  final String firstName;
  final String? middleName;
  final String lastName;
  final String? fullName;
  final bool locked;
  final bool disabled;
  final String? gender;
  final bool notificationsEnabled;
  final UserPreferences? preferences;
  final List<String> roles;
  final bool isFamilyManager;
  final bool isPrincipal;
  final int currentBalance;
  final DateTime? lastLoginDate;
  final String? referralCode;
  final bool isProfileCompleted;
  final UserMetadata? metadata;

  User({
    required this.id,
    required this.email,
    this.birthDate,
    this.mobile,
    this.countryCode,
    required this.mobileVerified,
    required this.emailVerified,
    required this.idVerified,
    this.code,
    required this.identityConfirmedTrials,
    required this.firstName,
    this.middleName,
    required this.lastName,
    this.fullName,
    required this.locked,
    required this.disabled,
    this.gender,
    required this.notificationsEnabled,
    this.preferences,
    required this.roles,
    required this.isFamilyManager,
    required this.isPrincipal,
    required this.currentBalance,
    this.lastLoginDate,
    this.referralCode,
    required this.isProfileCompleted,
    this.metadata,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      email: json['email'] as String,
      birthDate: json['birthDate'] != null
          ? DateTime.parse(json['birthDate'] as String)
          : null,
      mobile: json['mobile'] as String?,
      countryCode: json['countryCode'] as String?,
      mobileVerified: json['mobileVerified'] as bool? ?? false,
      emailVerified: json['emailVerified'] as bool? ?? false,
      idVerified: json['idVerified'] as bool? ?? false,
      code: json['code'] as String?,
      identityConfirmedTrials: json['identityConfirmedTrials'] as int? ?? 0,
      firstName: json['firstName'] as String,
      middleName: json['middleName'] as String?,
      lastName: json['lastName'] as String,
      fullName: json['fullName'] as String?,
      locked: json['locked'] as bool? ?? false,
      disabled: json['disabled'] as bool? ?? false,
      gender: json['gender'] as String?,
      notificationsEnabled: json['notificationsEnabled'] as bool? ?? true,
      preferences: json['preferences'] != null
          ? UserPreferences.fromJson(
              json['preferences'] as Map<String, dynamic>,
            )
          : null,
      roles: List<String>.from(json['roles'] as List? ?? []),
      isFamilyManager: json['isFamilyManager'] as bool? ?? false,
      isPrincipal: json['is_principal'] as bool? ?? false,
      currentBalance: json['currentBalance'] as int? ?? 0,
      lastLoginDate: json['lastLoginDate'] != null
          ? DateTime.parse(json['lastLoginDate'] as String)
          : null,
      referralCode: json['referralCode'] as String?,
      isProfileCompleted: json['isProfileCompleted'] as bool? ?? false,
      metadata: json['metadata'] != null
          ? UserMetadata.fromJson(json['metadata'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      if (birthDate != null) 'birthDate': birthDate?.toIso8601String(),
      if (mobile != null) 'mobile': mobile,
      if (countryCode != null) 'countryCode': countryCode,
      'mobileVerified': mobileVerified,
      'emailVerified': emailVerified,
      'idVerified': idVerified,
      if (code != null) 'code': code,
      'identityConfirmedTrials': identityConfirmedTrials,
      'firstName': firstName,
      if (middleName != null) 'middleName': middleName,
      'lastName': lastName,
      if (fullName != null) 'fullName': fullName,
      'locked': locked,
      'disabled': disabled,
      if (gender != null) 'gender': gender,
      'notificationsEnabled': notificationsEnabled,
      if (preferences != null) 'preferences': preferences?.toJson(),
      'roles': roles,
      'isFamilyManager': isFamilyManager,
      'is_principal': isPrincipal,
      'currentBalance': currentBalance,
      if (lastLoginDate != null)
        'lastLoginDate': lastLoginDate?.toIso8601String(),
      if (referralCode != null) 'referralCode': referralCode,
      'isProfileCompleted': isProfileCompleted,
      if (metadata != null) 'metadata': metadata?.toJson(),
    };
  }
}

class LoginResponse {
  final String? accessToken;
  final String? refreshToken;
  final DateTime? expireAt;
  final User? user;
  final String? message;

  LoginResponse({
    this.accessToken,
    this.refreshToken,
    this.expireAt,
    this.user,
    this.message,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      accessToken: json['access_token'] as String?,
      refreshToken: json['refresh_token'] as String?,
      expireAt: json['expireAt'] != null
          ? DateTime.parse(json['expireAt'] as String)
          : null,
      user: json['user'] != null
          ? User.fromJson(json['user'] as Map<String, dynamic>)
          : null,
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (accessToken != null) 'access_token': accessToken,
      if (refreshToken != null) 'refresh_token': refreshToken,
      if (expireAt != null) 'expireAt': expireAt?.toIso8601String(),
      if (user != null) 'user': user?.toJson(),
      if (message != null) 'message': message,
    };
  }
}
