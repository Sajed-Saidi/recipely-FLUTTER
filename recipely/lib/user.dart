import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:recipely/GLOBAL.dart';

const String _baseURL = 'recipely.atwebpages.com';

class User {
  final int id;
  final String email;
  final String password;

  User(this.id, this.email, this.password);

  @override
  String toString() {
    return 'ID: $id Email: $email Password: $password';
  }
}

List<User> _users = [];

void checkUserEmail(String email, Function(bool success) update) async {
  try {
    final url = Uri.http(_baseURL, 'checkUserEmail.php', {"email": email});
    print(url);
    final response = await http.get(url).timeout(const Duration(seconds: 5));
    if (response.statusCode == 200) {
      // if successful call
      _users = [];
      final jsonResponse = convert.jsonDecode(response.body);
      for (var row in jsonResponse) {
        User user = User(
          int.parse(row['id']),
          row['email'],
          row['password'],
        );
        _users.add(user);
        Global.globalUser = user;
      }
      update(true);
    }
  } catch (e) {
    update(false);
  }
}

void findUser(
    String email, String password, Function(bool success) update) async {
  try {
    final url = Uri.http(
        _baseURL, 'findUser.php', {"email": email, "password": password});
    print(url);
    final response = await http.get(url).timeout(const Duration(seconds: 5));
    if (response.statusCode == 200) {
      // if successful call
      _users = [];
      final jsonResponse = convert.jsonDecode(response.body);
      for (var row in jsonResponse) {
        User user = User(
          int.parse(row['id']),
          row['email'],
          row['password'],
        );
        _users.add(user);
      }
      update(true);
    }
  } catch (e) {
    update(false);
  }
}

void addUser(Function(String text, bool success) updateRegister, String email,
    String password) async {
  try {
    final response = await http
        .post(Uri.parse('http://$_baseURL/insertUser.php'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: convert.jsonEncode(<String, String>{
              'email': email,
              'password': password,
            }))
        .timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      // Parse the JSON response
      final responseBody = convert.jsonDecode(response.body);
      if (responseBody is Map<String, dynamic>) {
        final message = responseBody['message'];
        final id = responseBody['id'];
        print('Message: $message, ID: $id');
        _users = [];
        _users.add(User(id, email, password));
        updateRegister('Message: $message, ID: $id', true);
      } else {
        updateRegister('Unexpected response format', false);
      }
    } else {
      updateRegister('Error: ${response.statusCode}', false);
    }
  } catch (e) {
    updateRegister(e.toString(), false);
  }
}

bool userExists() {
  return _users.isNotEmpty;
}

User getUser() {
  return _users[0];
}
