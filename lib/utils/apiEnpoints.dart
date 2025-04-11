class ApiEndpoints {
  static final String baseUrl = 'http://10.0.2.2:8000'; //http://127.0.0.1:8000
  static final AuthEndpoints auth = AuthEndpoints();
  static final UserEndpoints user = UserEndpoints();
  static final AdminEndpoints admin = AdminEndpoints();
}

class AuthEndpoints {
  final String register = '/auths/register';
  final String login = '/auths/login';
  final String loginGoogle = '/auths/login-google';
}

class UserEndpoints {
  final String logout = '/users/logout';
  final String updatePassword = '/users/update_password';
  final String getUser = '/users/get-user';
  final String updateUser = '/users/update-user';
  final String history = '/cnn/history';
  final String deleteHistory = '/cnn/history';
  final String diagnosis = '/cnn/diagnosis';
  final String generate = '/llm/generate';
  final String createSession = '/llm/create_session';
  final String getSession = '/llm/user/session';
  final String getSessionMessages = '/llm/session/{session_id}/messages';
  final String diagnoses = '/cnn/predict';
}

class AdminEndpoints {
  final String signout = '/admins/sign_out';
}
