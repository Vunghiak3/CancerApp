class ApiEndpoints {
  static final String baseUrl = 'http://10.0.2.2:8000';
  // static final String baseUrl = 'http://127.0.0.1:8000';
  // static final String baseUrl = 'https://huge-wasp-early.ngrok-free.app';
  static final AuthEndpoints auth = AuthEndpoints();
  static final UserEndpoints user = UserEndpoints();
  static final CnnEndpoints cnn = CnnEndpoints();
  static final LlmEndPoints llm = LlmEndPoints();
}

class AuthEndpoints {
  final String register = '/auths/register';
  final String login = '/auths/login';
  final String loginGoogle = '/auths/login-google';
  final String signout = '/auths/sign_out';
}

class UserEndpoints {
  final String updatePassword = '/users/update_password';
  final String getUser = '/users/get-user';
  final String updateUser = '/users/update-user';
  final String deleteAccount = '/users/delete_user';
  final String updateProfilePicture = '/users/update-profile-picture';
}

class CnnEndpoints {
  final String history = '/cnn/history';
  final String deleteHistory = '/cnn/history';
  final String deleteMultiHistory = '/cnn/history-multi';
  final String diagnosis = '/cnn/diagnosis';
  final String diagnoses = '/cnn/predict';
}

class LlmEndPoints{
  final String generate = '/llm/generate';
  final String createSession = '/llm/create_session';
  final String getSession = '/llm/user/session';
  final String latestSession = '/llm/user/latest_session/';
  String getSessionMessages(String sessionId) => '/llm/session/$sessionId/messages';
  String deleteSessionById(String sessionId) => '/llm/session/$sessionId';
}
