class AuthService {
  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    if (email == "test@atts.com" && password == "123456") {
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    await Future.delayed(const Duration(seconds: 1));
  }
}
