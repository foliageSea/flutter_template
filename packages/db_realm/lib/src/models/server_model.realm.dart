// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_model.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
class ServerModel extends _ServerModel
    with RealmEntity, RealmObjectBase, RealmObject {
  ServerModel(
    ObjectId id,
    String url,
    String username,
    String password,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'url', url);
    RealmObjectBase.set(this, 'username', username);
    RealmObjectBase.set(this, 'password', password);
  }

  ServerModel._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, 'id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get url => RealmObjectBase.get<String>(this, 'url') as String;
  @override
  set url(String value) => RealmObjectBase.set(this, 'url', value);

  @override
  String get username =>
      RealmObjectBase.get<String>(this, 'username') as String;
  @override
  set username(String value) => RealmObjectBase.set(this, 'username', value);

  @override
  String get password =>
      RealmObjectBase.get<String>(this, 'password') as String;
  @override
  set password(String value) => RealmObjectBase.set(this, 'password', value);

  @override
  Stream<RealmObjectChanges<ServerModel>> get changes =>
      RealmObjectBase.getChanges<ServerModel>(this);

  @override
  Stream<RealmObjectChanges<ServerModel>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<ServerModel>(this, keyPaths);

  @override
  ServerModel freeze() => RealmObjectBase.freezeObject<ServerModel>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'url': url.toEJson(),
      'username': username.toEJson(),
      'password': password.toEJson(),
    };
  }

  static EJsonValue _toEJson(ServerModel value) => value.toEJson();
  static ServerModel _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'url': EJsonValue url,
        'username': EJsonValue username,
        'password': EJsonValue password,
      } =>
        ServerModel(
          fromEJson(id),
          fromEJson(url),
          fromEJson(username),
          fromEJson(password),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(ServerModel._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
        ObjectType.realmObject, ServerModel, 'ServerModel', [
      SchemaProperty('id', RealmPropertyType.objectid,
          indexType: RealmIndexType.regular),
      SchemaProperty('url', RealmPropertyType.string),
      SchemaProperty('username', RealmPropertyType.string),
      SchemaProperty('password', RealmPropertyType.string),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
