import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String username;
  final String email;
  final String photoUrl;
  final String displayName;
  final String bio;

  User({
    this.id,
    this.username,
    this.email,
    this.photoUrl,
    this.displayName,
    this.bio,
  });

  factory User.fromDocument(DocumentSnapshot docs) {
    return User(
      id: docs['id'],
      email: docs['email'],
      username: docs['username'],
      photoUrl: docs['photoUrl'],
      displayName: docs['displayName'],
      bio: docs['bio'],
    );
  }
}
