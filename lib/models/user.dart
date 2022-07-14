import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;

  final String bio;
  final String profileName;

  final String url;


  final String email;

  final bool blocked;

  User({
    this.id,

    this.bio,
    this.profileName,


    this.url,
    this.email,

    this.blocked,
  });

  factory User.fromDocument(DocumentSnapshot doc) {
    return User(
      id: doc.documentID,

        bio: doc['bio'],

        profileName: doc['profileName'],


        url: doc['url'],

        email: doc['email'],



      blocked: doc['blocked']
    );
  }
}