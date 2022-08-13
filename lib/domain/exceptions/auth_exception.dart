enum AuthErrorCode {
  notAuth,
  notChatUser,
}

class AuthException implements Exception {
  AuthException(this.error);
  final AuthErrorCode error;
}
