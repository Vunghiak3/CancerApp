class ApiEndpoints {
  static final String baseUrl = 'http://10.0.2.2:8000';
  static final AuthEndpoints auth = AuthEndpoints();
  static final Userendpoints user = Userendpoints();
}

class AuthEndpoints {
  final String register = '/auth/register';
  final String login = '/auth/login';
  final String loginGoogle = '/auth/login-google';
}

class Userendpoints {
  final String logout = '/users/logout';
  final String updatePassword = '/users/update_password';
  final String getUser = '/users/get-user';
}
