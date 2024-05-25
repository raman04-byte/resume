import '../models/user.dart';

class AuthenticationRepository {
  Future<User?> authenticate(String name, String companyName) async {
    await Future.delayed(const Duration(seconds: 1));
    return User(name: name, companyName: companyName);
  }
}
