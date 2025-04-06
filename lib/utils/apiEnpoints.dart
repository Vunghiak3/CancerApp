class ApiEndpoints {
  static final String baseUrl = 'http://10.0.2.2:8000';
  static final _AuthEndpoints auth = _AuthEndpoints();
  static final _Userenpoints user = _Userenpoints();
}

class _AuthEndpoints {
  final String register = '/auths/register';
  final String login = '/auths/login';
}

class _Userenpoints {
  final String logout = '/users/logout';
}
