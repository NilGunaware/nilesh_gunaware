class BSpokUser {
  final String id;
  final String email;
  final String name;
  final String firstName;
  final String lastName;
  final String? phoneNumber;
  final String? profileImage;
  final String? address;
  final String? city;
  final String? state;
  final String? country;
  final String? postalCode;
  final bool isEmailVerified;
  final bool isPhoneVerified;
  final String userType; // customer, admin, etc.
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? lastLoginAt;

  BSpokUser({
    required this.id,
    required this.email,
    required this.name,
    required this.firstName,
    required this.lastName,
    this.phoneNumber,
    this.profileImage,
    this.address,
    this.city,
    this.state,
    this.country,
    this.postalCode,
    required this.isEmailVerified,
    required this.isPhoneVerified,
    required this.userType,
    required this.createdAt,
    required this.updatedAt,
    this.lastLoginAt,
  });

  factory BSpokUser.fromJson(Map<String, dynamic> json) {
    return BSpokUser(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      phoneNumber: json['phone_number'],
      profileImage: json['profile_image'],
      address: json['address'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
      postalCode: json['postal_code'],
      isEmailVerified: json['is_email_verified'] ?? false,
      isPhoneVerified: json['is_phone_verified'] ?? false,
      userType: json['user_type'] ?? 'customer',
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      lastLoginAt: json['last_login_at'] != null 
          ? DateTime.parse(json['last_login_at']) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'first_name': firstName,
      'last_name': lastName,
      'phone_number': phoneNumber,
      'profile_image': profileImage,
      'address': address,
      'city': city,
      'state': state,
      'country': country,
      'postal_code': postalCode,
      'is_email_verified': isEmailVerified,
      'is_phone_verified': isPhoneVerified,
      'user_type': userType,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'last_login_at': lastLoginAt?.toIso8601String(),
    };
  }

  String get fullName => '$firstName $lastName';

  BSpokUser copyWith({
    String? id,
    String? email,
    String? name,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? profileImage,
    String? address,
    String? city,
    String? state,
    String? country,
    String? postalCode,
    bool? isEmailVerified,
    bool? isPhoneVerified,
    String? userType,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastLoginAt,
  }) {
    return BSpokUser(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profileImage: profileImage ?? this.profileImage,
      address: address ?? this.address,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      postalCode: postalCode ?? this.postalCode,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      isPhoneVerified: isPhoneVerified ?? this.isPhoneVerified,
      userType: userType ?? this.userType,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
    );
  }
} 