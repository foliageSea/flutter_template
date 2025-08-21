class Constant {
  Constant._();

  static const String jwtSecret = 'a9a98d77d5f9102fe86356c9bd2e1e65';

  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
    'Access-Control-Allow-Headers': 'Origin, Content-Type, Authorization',
  };
}
