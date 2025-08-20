// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'result.dart';

class ResultMapper extends ClassMapperBase<Result> {
  ResultMapper._();

  static ResultMapper? _instance;
  static ResultMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ResultMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Result';
  @override
  Function get typeFactory =>
      <T>(f) => f<Result<T>>();

  static int _$code(Result v) => v.code;
  static const Field<Result, int> _f$code = Field('code', _$code);
  static bool _$success(Result v) => v.success;
  static const Field<Result, bool> _f$success = Field('success', _$success);
  static String _$message(Result v) => v.message;
  static const Field<Result, String> _f$message = Field('message', _$message);
  static dynamic _$data(Result v) => v.data;
  static dynamic _arg$data<T>(f) => f<T>();
  static const Field<Result, dynamic> _f$data = Field(
    'data',
    _$data,
    arg: _arg$data,
  );

  @override
  final MappableFields<Result> fields = const {
    #code: _f$code,
    #success: _f$success,
    #message: _f$message,
    #data: _f$data,
  };

  static Result<T> _instantiate<T>(DecodingData data) {
    return Result(
      data.dec(_f$code),
      data.dec(_f$success),
      data.dec(_f$message),
      data.dec(_f$data),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static Result<T> fromMap<T>(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Result<T>>(map);
  }

  static Result<T> fromJson<T>(String json) {
    return ensureInitialized().decodeJson<Result<T>>(json);
  }
}

mixin ResultMappable<T> {
  String toJson() {
    return ResultMapper.ensureInitialized().encodeJson<Result<T>>(
      this as Result<T>,
    );
  }

  Map<String, dynamic> toMap() {
    return ResultMapper.ensureInitialized().encodeMap<Result<T>>(
      this as Result<T>,
    );
  }

  ResultCopyWith<Result<T>, Result<T>, Result<T>, T> get copyWith =>
      _ResultCopyWithImpl<Result<T>, Result<T>, T>(
        this as Result<T>,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ResultMapper.ensureInitialized().stringifyValue(this as Result<T>);
  }

  @override
  bool operator ==(Object other) {
    return ResultMapper.ensureInitialized().equalsValue(
      this as Result<T>,
      other,
    );
  }

  @override
  int get hashCode {
    return ResultMapper.ensureInitialized().hashValue(this as Result<T>);
  }
}

extension ResultValueCopy<$R, $Out, T> on ObjectCopyWith<$R, Result<T>, $Out> {
  ResultCopyWith<$R, Result<T>, $Out, T> get $asResult =>
      $base.as((v, t, t2) => _ResultCopyWithImpl<$R, $Out, T>(v, t, t2));
}

abstract class ResultCopyWith<$R, $In extends Result<T>, $Out, T>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({int? code, bool? success, String? message, T? data});
  ResultCopyWith<$R2, $In, $Out2, T> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ResultCopyWithImpl<$R, $Out, T>
    extends ClassCopyWithBase<$R, Result<T>, $Out>
    implements ResultCopyWith<$R, Result<T>, $Out, T> {
  _ResultCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Result> $mapper = ResultMapper.ensureInitialized();
  @override
  $R call({int? code, bool? success, String? message, Object? data = $none}) =>
      $apply(
        FieldCopyWithData({
          if (code != null) #code: code,
          if (success != null) #success: success,
          if (message != null) #message: message,
          if (data != $none) #data: data,
        }),
      );
  @override
  Result<T> $make(CopyWithData data) => Result(
    data.get(#code, or: $value.code),
    data.get(#success, or: $value.success),
    data.get(#message, or: $value.message),
    data.get(#data, or: $value.data),
  );

  @override
  ResultCopyWith<$R2, Result<T>, $Out2, T> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ResultCopyWithImpl<$R2, $Out2, T>($value, $cast, t);
}

