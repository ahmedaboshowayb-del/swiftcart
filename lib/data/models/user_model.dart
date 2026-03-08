import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/user_entity.dart';

class UserModel {
  const UserModel({
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

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final d = doc.data() as Map<String, dynamic>;
    return UserModel(
      id:          doc.id,
      email:       d['email']        as String?  ?? '',
      fullName:    d['full_name']    as String?  ?? '',
      phoneNumber: d['phone_number'] as String?,
      photoUrl:    d['photo_url']    as String?,
      addresses:   List<String>.from(d['addresses'] as List? ?? []),
      createdAt:   (d['created_at'] as Timestamp?)?.toDate() ?? DateTime.now(),
      fcmToken:    d['fcm_token']    as String?,
    );
  }

  Map<String, dynamic> toFirestore() => {
    'email':        email,
    'full_name':    fullName,
    'phone_number': phoneNumber,
    'photo_url':    photoUrl,
    'addresses':    addresses,
    'created_at':   Timestamp.fromDate(createdAt),
    'fcm_token':    fcmToken,
  };

  UserEntity toEntity() => UserEntity(
    id:          id,
    email:       email,
    fullName:    fullName,
    phoneNumber: phoneNumber,
    photoUrl:    photoUrl,
    addresses:   addresses,
    createdAt:   createdAt,
    fcmToken:    fcmToken,
  );
}