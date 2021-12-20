import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io' as Io;
import 'global.dart';

class User {
  final String id;
  final String firstName;
  final String lastName;
  final String emailAddress;
  final DateTime createdDate;

  User(
    this.id,
    this.firstName,
    this.lastName,
    this.emailAddress,
    this.createdDate,
  );
  User.fromJson(Map<String, dynamic> json)
      : id = json['Id'],
        firstName = json['FirstName'],
        lastName = json['LastName'],
        emailAddress = json['EmailAddress'],
        createdDate = json['CreatedDate'];

  // String? Global.token = "";
  Future<void> registerUser(
    String firstName,
    String lastName,
    String emailAddress,
    String password,
  ) async {
    var url = Uri.parse('https://localhost:44333/api/Account/Register');
    try {
      final body = jsonEncode(
        {
          "Email": emailAddress,
          "Password": password,
          "ConfirmPassword": password,
        },
      );
      final response = await http.post(
        url,
        body: body,
      );
      if (response.statusCode == 200) {
        var url = Uri.parse('https://localhost:44333/Global.token');
        final body = jsonEncode(
          {
            "username": emailAddress,
            "Password": password,
          },
        );
        final response = await http.post(
          url,
          body: body,
        );
        if (response.statusCode == 200) {
          final jsonResponse = jsonDecode(response.body);
          Global.token = jsonResponse["access_token"];
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signIn(
    String email,
    String password,
  ) async {
    try {
      var url = Uri.parse('https://localhost:44333/Global.token');
      final body = jsonEncode(
        {
          "username": email,
          "Password": password,
        },
      );
      final response = await http.post(
        url,
        body: body,
      );
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        Global.token = jsonResponse["access_token"];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> setUser() async {
    try {
      var url = Uri.parse('https://localhost:44333/api/User');
      final body = jsonEncode(
        {
          "access_token": Global.token,
        },
      );
      final response = await http.post(
        url,
        body: body,
      );
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        User.fromJson(
          jsonResponse,
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut(
    User user,
  ) async {
    try {
      var url = Uri.parse('https://localhost:44333/Account/Logout');
      final body = jsonEncode(
        {
          "access_token": Global.token,
        },
      );
      final response = await http.post(
        url,
        body: body,
      );
      if (response.statusCode == 200) {
        Global.token = "";
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> uploadImages(
    List<XFile> images,
  ) async {
    var url = Uri.parse('https://localhost:44333/Account/Logout');
    try {
      File file = File(images[0].path);

      final bytes = await Io.File(
        file.toString(),
      ).readAsBytes();

      final body = jsonEncode(
        {
          "access_token": Global.token,
          "image": bytes,
        },
      );
      final response = await http.post(
        url,
        body: body,
      );
      if (response.statusCode == 200) {
        Global.token = "";
      }
    } catch (e) {
      rethrow;
    }
  }
}
