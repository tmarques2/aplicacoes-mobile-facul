class TokenService {
  String? _accessToken;

  String? get accessToken => accessToken;
  void saveToken(String token) => _accessToken = token;
  void clearToken() => _accessToken = null;
}
