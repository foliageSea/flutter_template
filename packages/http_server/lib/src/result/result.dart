import 'dart:convert';
import 'dart:io';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:http_server/src/constant/constant.dart';
import 'package:shelf_plus/shelf_plus.dart';

part 'result.mapper.dart';

@MappableClass()
class Result<T> with ResultMappable {
  late int code;
  late bool success;
  late String message;

  late T? data;

  Result(this.code, this.success, this.message, this.data);

  static Response ok<T>(T? data) {
    var map = Result<T>(HttpStatus.ok, true, '', data).toMap();
    _removeTypeField(map);
    return Response.ok(jsonEncode(map), headers: Constant.headers);
  }

  static Response error<T>(String message, {int code = HttpStatus.badRequest}) {
    var map = Result<T>(code, false, message, null).toMap();
    _removeTypeField(map);

    return Response.badRequest(
      body: jsonEncode(map),
      headers: Constant.headers,
    );
  }

  static Response unauthorized<T>({String message = 'Unauthorized'}) {
    var map = Result<T>(HttpStatus.unauthorized, false, message, null).toMap();
    _removeTypeField(map);
    return Response.unauthorized(jsonEncode(map), headers: Constant.headers);
  }

  static Response internalServerError<T>(String message) {
    var map = Result<T>(
      HttpStatus.internalServerError,
      false,
      message,
      null,
    ).toMap();
    _removeTypeField(map);
    return Response.internalServerError(
      body: jsonEncode(map),
      headers: Constant.headers,
    );
  }

  static void _removeTypeField(Map<String, dynamic> map) {
    map.remove('__type');
  }
}
