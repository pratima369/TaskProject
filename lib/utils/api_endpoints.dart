class ApiEndPoints {
  static final String baseUrl = 'https://api.escuelajs.co/api/v1/';
  static _AuthEndPoints authEndpoints = _AuthEndPoints();

}


class _AuthEndPoints {
  final String registerEmail = "/users/is-available";
  final String loginEmail = "/auth/login/";
}