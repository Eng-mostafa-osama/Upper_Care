import 'package:flutter/material.dart';

class User {
  final String id;
  final String name;
  final String phone;
  final String email;
  final String location;
  final String role;

  User({
    required this. id,
    required this.name,
    required this.phone,
    required this.email,
    required this.location,
    required this.role,
  });
}

class AuthProvider extends ChangeNotifier {
  User?  _currentUser;
  bool _isLoggedIn = false;

  User?  get currentUser => _currentUser;
  bool get isLoggedIn => _isLoggedIn;
  bool get isLoading => false; // مش محتاج loading

  Future<bool> login({
    required String name,
    required String phone,
    required String password,
    String? email,
    String? location,
    required String role,
  }) async {
    if (phone.isEmpty || password.isEmpty) {
      return false;
    }

    final id = DateTime.now().millisecondsSinceEpoch.toString();

    _currentUser = User(
      id: id,
      name: name. isNotEmpty ? name : phone,
      phone: phone,
      email: email ?? '',
      location: location ?? '',
      role: role,
    );
    _isLoggedIn = true;

    notifyListeners();
    return true;
  }

  Future<bool> register({
    required String name,
    required String phone,
    required String password,
    String? email,
    String? location,
    required String role,
  }) async {
    return login(
      name: name,
      phone: phone,
      password: password,
      email: email,
      location: location,
      role: role,
    );
  }

  Future<void> logout() async {
    _currentUser = null;
    _isLoggedIn = false;
    notifyListeners();
  }

  bool hasValidUserData() {
    return _isLoggedIn && _currentUser != null;
  }
}

final authProvider = AuthProvider();