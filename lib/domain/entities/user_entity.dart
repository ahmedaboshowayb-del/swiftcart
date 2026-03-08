import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.id,
    required this.email,
    required this.fullName,
    required this.addresses,
    required this.createdAt,
    this.phoneNumber,
    this.photoUrl,
    this.fcmToken,
  });

  final String  id;
  final String  email;
  final String  fullName;
  final String? phoneNumber;
  final String? photoUrl;
  final List<String> addresses;
  final DateTime createdAt;
  final String? fcmToken;

  String get firstName  => fullName.split(' ').first;
  bool   get hasPhoto   => photoUrl != null && photoUrl!.isNotEmpty;
  bool   get hasPhone   => phoneNumber != null && phoneNumber!.isNotEmpty;
  bool   get hasAddress => addresses.isNotEmpty;

  UserEntity copyWith({
    String?       id,
    String?       email,
    String?       fullName,
    String?       phoneNumber,
    String?       photoUrl,
    List<String>? addresses,
    DateTime?     createdAt,
    String?       fcmToken,
  }) =>
      UserEntity(
        id:          id          ?? this.id,
        email:       email       ?? this.email,
        fullName:    fullName    ?? this.fullName,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        photoUrl:    photoUrl    ?? this.photoUrl,
        addresses:   addresses   ?? this.addresses,
        createdAt:   createdAt   ?? this.createdAt,
        fcmToken:    fcmToken    ?? this.fcmToken,
      );

  @override
  List<Object?> get props => [id, email, fullName];
}