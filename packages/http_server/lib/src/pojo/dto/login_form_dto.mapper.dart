// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'login_form_dto.dart';

class LoginFormDtoMapper extends ClassMapperBase<LoginFormDto> {
  LoginFormDtoMapper._();

  static LoginFormDtoMapper? _instance;
  static LoginFormDtoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LoginFormDtoMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'LoginFormDto';

  static String _$username(LoginFormDto v) => v.username;
  static const Field<LoginFormDto, String> _f$username =
      Field('username', _$username, opt: true, def: "");
  static String _$password(LoginFormDto v) => v.password;
  static const Field<LoginFormDto, String> _f$password =
      Field('password', _$password, opt: true, def: "");

  @override
  final MappableFields<LoginFormDto> fields = const {
    #username: _f$username,
    #password: _f$password,
  };

  static LoginFormDto _instantiate(DecodingData data) {
    return LoginFormDto(
        username: data.dec(_f$username), password: data.dec(_f$password));
  }

  @override
  final Function instantiate = _instantiate;

  static LoginFormDto fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LoginFormDto>(map);
  }

  static LoginFormDto fromJson(String json) {
    return ensureInitialized().decodeJson<LoginFormDto>(json);
  }
}

mixin LoginFormDtoMappable {
  String toJson() {
    return LoginFormDtoMapper.ensureInitialized()
        .encodeJson<LoginFormDto>(this as LoginFormDto);
  }

  Map<String, dynamic> toMap() {
    return LoginFormDtoMapper.ensureInitialized()
        .encodeMap<LoginFormDto>(this as LoginFormDto);
  }

  LoginFormDtoCopyWith<LoginFormDto, LoginFormDto, LoginFormDto> get copyWith =>
      _LoginFormDtoCopyWithImpl<LoginFormDto, LoginFormDto>(
          this as LoginFormDto, $identity, $identity);
  @override
  String toString() {
    return LoginFormDtoMapper.ensureInitialized()
        .stringifyValue(this as LoginFormDto);
  }

  @override
  bool operator ==(Object other) {
    return LoginFormDtoMapper.ensureInitialized()
        .equalsValue(this as LoginFormDto, other);
  }

  @override
  int get hashCode {
    return LoginFormDtoMapper.ensureInitialized()
        .hashValue(this as LoginFormDto);
  }
}

extension LoginFormDtoValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LoginFormDto, $Out> {
  LoginFormDtoCopyWith<$R, LoginFormDto, $Out> get $asLoginFormDto =>
      $base.as((v, t, t2) => _LoginFormDtoCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class LoginFormDtoCopyWith<$R, $In extends LoginFormDto, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? username, String? password});
  LoginFormDtoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _LoginFormDtoCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LoginFormDto, $Out>
    implements LoginFormDtoCopyWith<$R, LoginFormDto, $Out> {
  _LoginFormDtoCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LoginFormDto> $mapper =
      LoginFormDtoMapper.ensureInitialized();
  @override
  $R call({String? username, String? password}) => $apply(FieldCopyWithData({
        if (username != null) #username: username,
        if (password != null) #password: password
      }));
  @override
  LoginFormDto $make(CopyWithData data) => LoginFormDto(
      username: data.get(#username, or: $value.username),
      password: data.get(#password, or: $value.password));

  @override
  LoginFormDtoCopyWith<$R2, LoginFormDto, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _LoginFormDtoCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
