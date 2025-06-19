import '../models/user_model.dart';

class AuthService {
  final List<UserModel> _users = [
    UserModel(email: "test@test.com", password: "123456"),
    UserModel(email: "demo@demo.com", password: "654321"),
  ];

  String? _loggedInEmail;

  bool isLoggedIn() => _loggedInEmail != null;

  Future<String> login(String email, String password) async {
    await Future.delayed(Duration(seconds: 1));
    final user = _users.firstWhere((u) => u.email == email, orElse: () => UserModel(email: '', password: ''));

    if (user.email.isEmpty) return "Email not found";
    if (user.password != password) return "Incorrect password";

    _loggedInEmail = user.email;
    return "success";
  }

  void logout() {
    _loggedInEmail = null;
  }

  void register(String email, String password) {
    _users.add(UserModel(email: email, password: password));
    _loggedInEmail = email;
  }
}
