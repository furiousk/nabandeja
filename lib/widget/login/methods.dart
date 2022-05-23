import '../../model/auth.dart';
import '../../service/api_client.dart';

class Methods {
  final ApiClient _api = ApiClient();

  Future<bool> auth(String login, String password) async {
    Auth userLogin = Auth(
      login: login,
      password: password,
      keepAlive: false,
    );

    final data = await _api.login(userLogin);
    if (data.authenticated == true) {
      return true;
    }
    return false;
  }
}
