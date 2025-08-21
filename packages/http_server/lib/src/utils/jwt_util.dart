import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

import '../constant/constant.dart';

class JwtUtil {
  static const String secret = Constant.jwtSecret;
  static Duration expiresIn = const Duration(hours: 1);

  static String generateToken(Map<String, dynamic> payload) {
    final jwt = JWT(payload);
    return jwt.sign(SecretKey(secret), expiresIn: expiresIn);
  }

  static dynamic verifyToken(String token) {
    final jwt = JWT.verify(token, SecretKey(secret));
    return jwt.payload;
  }
}
