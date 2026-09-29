import 'package:cloud_firestore/cloud_firestore.dart';

class Profile {
  const Profile({
    required this.id,
    this.displayName,
    this.username,
    this.avatarUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String? displayName;
  final String? username;
  final String? avatarUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Profile.fromFirestore(String id, Map<String, dynamic> data) =>
      Profile(
        id: id,
        displayName: data['displayName'] as String?,
        username: data['username'] as String?,
        avatarUrl: data['avatarUrl'] as String?,
        createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
        updatedAt: (data['updatedAt'] as Timestamp?)?.toDate(),
      );
}
