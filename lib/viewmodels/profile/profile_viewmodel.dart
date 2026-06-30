import 'package:flutter/material.dart';
import 'package:xmuse/services/auth_service.dart';

class ProfileViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();

  Future<void> logout() async {
    await _authService.logout();
  }

  void updateDependencies(dynamic, login, dynamic register) {
    notifyListeners();
  }
}
