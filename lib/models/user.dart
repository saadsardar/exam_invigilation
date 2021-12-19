import 'dart:io';

class User {
  final String id;
  final String firstName;
  final String lastName;
  final String emailAddress;
  final DateTime createdDate;
  final String userToken;

  User(
    this.id,
    this.firstName,
    this.lastName,
    this.emailAddress,
    this.createdDate,
    this.userToken,
  );
  User.fromJson(Map<String, dynamic> json)
      : id = json['ID'],
        firstName = json['FirstName'],
        lastName = json['LastName'],
        emailAddress = json['EmailAddress'],
        createdDate = json['CreatedDate'],
        userToken = json['userToken'];
}

Future<void> registerUser(
  String firstName,
  String lastName,
  String emailAddress,
  String password,
) async {}
Future<void> signIn(
  String email,
  String password,
) async {}
Future<void> setUser() async {}
Future<void> signOut(
  User user,
) async {}
Future<void> uploadImages(
  String id,
  File image,
) async {}
