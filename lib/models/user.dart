import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

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
}

String? token = "";
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
      var url = Uri.parse('https://localhost:44333/token');
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
        token = jsonResponse["access_token"];
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
    var url = Uri.parse('https://localhost:44333/token');
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
      token = jsonResponse["access_token"];
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
        "access_token": token,
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
        "access_token": token,
      },
    );
    final response = await http.post(
      url,
      body: body,
    );
    if (response.statusCode == 200) {
      token = null;
    }
  } catch (e) {
    rethrow;
  }
}

// Future<void> uploadImages(
//   String id,
//   File image,
// ) async {
//   try {
//     final response = await http.get(url, headers: {
//       "app-id": "61b8b0f3309ad65ae828da3e",
//     });
//     final jsonResponse = jsonDecode(response.body);
//     // final postList = Post.fromJson(jsonResponse['data']) as List;
//     final postList = (jsonResponse["data"] as List)
//         .map(
//           (e) => User.fromJson(e),
//         )
//         .toList();
//   } catch (e) {
//     rethrow;
//   }
// }
