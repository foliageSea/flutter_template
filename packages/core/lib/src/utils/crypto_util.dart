import 'dart:convert';
import 'package:crypto/crypto.dart' as c;

class CryptoUtil {
  static String md5(String input) {
    return c.md5.convert(utf8.encode(input)).toString();
  }
}
