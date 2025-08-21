// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'business_exception.dart';

class BusinessExceptionMapper extends ClassMapperBase<BusinessException> {
  BusinessExceptionMapper._();

  static BusinessExceptionMapper? _instance;
  static BusinessExceptionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BusinessExceptionMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'BusinessException';

  static int _$code(BusinessException v) => v.code;
  static const Field<BusinessException, int> _f$code = Field('code', _$code);
  static String _$message(BusinessException v) => v.message;
  static const Field<BusinessException, String> _f$message =
      Field('message', _$message);
  static dynamic _$data(BusinessException v) => v.data;
  static const Field<BusinessException, dynamic> _f$data =
      Field('data', _$data, opt: true);

  @override
  final MappableFields<BusinessException> fields = const {
    #code: _f$code,
    #message: _f$message,
    #data: _f$data,
  };

  static BusinessException _instantiate(DecodingData data) {
    return BusinessException(
        code: data.dec(_f$code),
        message: data.dec(_f$message),
        data: data.dec(_f$data));
  }

  @override
  final Function instantiate = _instantiate;

  static BusinessException fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BusinessException>(map);
  }

  static BusinessException fromJson(String json) {
    return ensureInitialized().decodeJson<BusinessException>(json);
  }
}

mixin BusinessExceptionMappable {
  String toJson() {
    return BusinessExceptionMapper.ensureInitialized()
        .encodeJson<BusinessException>(this as BusinessException);
  }

  Map<String, dynamic> toMap() {
    return BusinessExceptionMapper.ensureInitialized()
        .encodeMap<BusinessException>(this as BusinessException);
  }

  BusinessExceptionCopyWith<BusinessException, BusinessException,
          BusinessException>
      get copyWith =>
          _BusinessExceptionCopyWithImpl<BusinessException, BusinessException>(
              this as BusinessException, $identity, $identity);
  @override
  String toString() {
    return BusinessExceptionMapper.ensureInitialized()
        .stringifyValue(this as BusinessException);
  }

  @override
  bool operator ==(Object other) {
    return BusinessExceptionMapper.ensureInitialized()
        .equalsValue(this as BusinessException, other);
  }

  @override
  int get hashCode {
    return BusinessExceptionMapper.ensureInitialized()
        .hashValue(this as BusinessException);
  }
}

extension BusinessExceptionValueCopy<$R, $Out>
    on ObjectCopyWith<$R, BusinessException, $Out> {
  BusinessExceptionCopyWith<$R, BusinessException, $Out>
      get $asBusinessException => $base
          .as((v, t, t2) => _BusinessExceptionCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class BusinessExceptionCopyWith<$R, $In extends BusinessException,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call({int? code, String? message, dynamic data});
  BusinessExceptionCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _BusinessExceptionCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BusinessException, $Out>
    implements BusinessExceptionCopyWith<$R, BusinessException, $Out> {
  _BusinessExceptionCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BusinessException> $mapper =
      BusinessExceptionMapper.ensureInitialized();
  @override
  $R call({int? code, String? message, Object? data = $none}) =>
      $apply(FieldCopyWithData({
        if (code != null) #code: code,
        if (message != null) #message: message,
        if (data != $none) #data: data
      }));
  @override
  BusinessException $make(CopyWithData data) => BusinessException(
      code: data.get(#code, or: $value.code),
      message: data.get(#message, or: $value.message),
      data: data.get(#data, or: $value.data));

  @override
  BusinessExceptionCopyWith<$R2, BusinessException, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _BusinessExceptionCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
