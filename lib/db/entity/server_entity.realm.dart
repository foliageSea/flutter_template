// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_entity.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
class ServerEntity extends _ServerEntity
    with RealmEntity, RealmObjectBase, RealmObject {
  ServerEntity(
    ObjectId id,
    String name,
    String url,
    String description,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'url', url);
    RealmObjectBase.set(this, 'description', description);
  }

  ServerEntity._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, 'id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  String get url => RealmObjectBase.get<String>(this, 'url') as String;
  @override
  set url(String value) => RealmObjectBase.set(this, 'url', value);

  @override
  String get description =>
      RealmObjectBase.get<String>(this, 'description') as String;
  @override
  set description(String value) =>
      RealmObjectBase.set(this, 'description', value);

  @override
  Stream<RealmObjectChanges<ServerEntity>> get changes =>
      RealmObjectBase.getChanges<ServerEntity>(this);

  @override
  Stream<RealmObjectChanges<ServerEntity>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<ServerEntity>(this, keyPaths);

  @override
  ServerEntity freeze() => RealmObjectBase.freezeObject<ServerEntity>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'name': name.toEJson(),
      'url': url.toEJson(),
      'description': description.toEJson(),
    };
  }

  static EJsonValue _toEJson(ServerEntity value) => value.toEJson();
  static ServerEntity _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'name': EJsonValue name,
        'url': EJsonValue url,
        'description': EJsonValue description,
      } =>
        ServerEntity(
          fromEJson(id),
          fromEJson(name),
          fromEJson(url),
          fromEJson(description),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(ServerEntity._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
        ObjectType.realmObject, ServerEntity, 'ServerEntity', [
      SchemaProperty('id', RealmPropertyType.objectid,
          indexType: RealmIndexType.regular),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('url', RealmPropertyType.string),
      SchemaProperty('description', RealmPropertyType.string),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
