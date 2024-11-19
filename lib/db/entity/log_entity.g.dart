// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_entity.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetLogEntityCollection on Isar {
  IsarCollection<LogEntity> get logEntitys => this.collection();
}

const LogEntitySchema = CollectionSchema(
  name: r'LogEntity',
  id: 3974793294907107472,
  properties: {
    r'displayError': PropertySchema(
      id: 0,
      name: r'displayError',
      type: IsarType.string,
    ),
    r'displayException': PropertySchema(
      id: 1,
      name: r'displayException',
      type: IsarType.string,
    ),
    r'logLevel': PropertySchema(
      id: 2,
      name: r'logLevel',
      type: IsarType.string,
    ),
    r'message': PropertySchema(
      id: 3,
      name: r'message',
      type: IsarType.string,
    ),
    r'textMessage': PropertySchema(
      id: 4,
      name: r'textMessage',
      type: IsarType.string,
    ),
    r'title': PropertySchema(
      id: 5,
      name: r'title',
      type: IsarType.string,
    ),
    r'update': PropertySchema(
      id: 6,
      name: r'update',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _logEntityEstimateSize,
  serialize: _logEntitySerialize,
  deserialize: _logEntityDeserialize,
  deserializeProp: _logEntityDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _logEntityGetId,
  getLinks: _logEntityGetLinks,
  attach: _logEntityAttach,
  version: '3.1.0',
);

int _logEntityEstimateSize(
  LogEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.displayError;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.displayException;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.logLevel;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.message;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.textMessage;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.title;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _logEntitySerialize(
  LogEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.displayError);
  writer.writeString(offsets[1], object.displayException);
  writer.writeString(offsets[2], object.logLevel);
  writer.writeString(offsets[3], object.message);
  writer.writeString(offsets[4], object.textMessage);
  writer.writeString(offsets[5], object.title);
  writer.writeDateTime(offsets[6], object.update);
}

LogEntity _logEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = LogEntity();
  object.displayError = reader.readStringOrNull(offsets[0]);
  object.displayException = reader.readStringOrNull(offsets[1]);
  object.id = id;
  object.logLevel = reader.readStringOrNull(offsets[2]);
  object.message = reader.readStringOrNull(offsets[3]);
  object.textMessage = reader.readStringOrNull(offsets[4]);
  object.title = reader.readStringOrNull(offsets[5]);
  object.update = reader.readDateTimeOrNull(offsets[6]);
  return object;
}

P _logEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readDateTimeOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _logEntityGetId(LogEntity object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _logEntityGetLinks(LogEntity object) {
  return [];
}

void _logEntityAttach(IsarCollection<dynamic> col, Id id, LogEntity object) {
  object.id = id;
}

extension LogEntityQueryWhereSort
    on QueryBuilder<LogEntity, LogEntity, QWhere> {
  QueryBuilder<LogEntity, LogEntity, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension LogEntityQueryWhere
    on QueryBuilder<LogEntity, LogEntity, QWhereClause> {
  QueryBuilder<LogEntity, LogEntity, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension LogEntityQueryFilter
    on QueryBuilder<LogEntity, LogEntity, QFilterCondition> {
  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition>
      displayErrorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'displayError',
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition>
      displayErrorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'displayError',
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition> displayErrorEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'displayError',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition>
      displayErrorGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'displayError',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition>
      displayErrorLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'displayError',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition> displayErrorBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'displayError',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition>
      displayErrorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'displayError',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition>
      displayErrorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'displayError',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition>
      displayErrorContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'displayError',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition> displayErrorMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'displayError',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition>
      displayErrorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'displayError',
        value: '',
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition>
      displayErrorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'displayError',
        value: '',
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition>
      displayExceptionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'displayException',
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition>
      displayExceptionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'displayException',
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition>
      displayExceptionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'displayException',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition>
      displayExceptionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'displayException',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition>
      displayExceptionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'displayException',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition>
      displayExceptionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'displayException',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition>
      displayExceptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'displayException',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition>
      displayExceptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'displayException',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition>
      displayExceptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'displayException',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition>
      displayExceptionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'displayException',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition>
      displayExceptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'displayException',
        value: '',
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition>
      displayExceptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'displayException',
        value: '',
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition> logLevelIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'logLevel',
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition>
      logLevelIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'logLevel',
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition> logLevelEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'logLevel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition> logLevelGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'logLevel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition> logLevelLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'logLevel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition> logLevelBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'logLevel',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition> logLevelStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'logLevel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition> logLevelEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'logLevel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition> logLevelContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'logLevel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition> logLevelMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'logLevel',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition> logLevelIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'logLevel',
        value: '',
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition>
      logLevelIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'logLevel',
        value: '',
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition> messageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'message',
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition> messageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'message',
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition> messageEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'message',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition> messageGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'message',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition> messageLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'message',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition> messageBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'message',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition> messageStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'message',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition> messageEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'message',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition> messageContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'message',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition> messageMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'message',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition> messageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'message',
        value: '',
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition>
      messageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'message',
        value: '',
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition>
      textMessageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'textMessage',
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition>
      textMessageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'textMessage',
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition> textMessageEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'textMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition>
      textMessageGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'textMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition> textMessageLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'textMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition> textMessageBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'textMessage',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition>
      textMessageStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'textMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition> textMessageEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'textMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition> textMessageContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'textMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition> textMessageMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'textMessage',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition>
      textMessageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'textMessage',
        value: '',
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition>
      textMessageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'textMessage',
        value: '',
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition> titleIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'title',
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition> titleIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'title',
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition> titleEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition> titleGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition> titleLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition> titleBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition> titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition> titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition> titleContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition> titleMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition> titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition> titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition> updateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'update',
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition> updateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'update',
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition> updateEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'update',
        value: value,
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition> updateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'update',
        value: value,
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition> updateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'update',
        value: value,
      ));
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterFilterCondition> updateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'update',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension LogEntityQueryObject
    on QueryBuilder<LogEntity, LogEntity, QFilterCondition> {}

extension LogEntityQueryLinks
    on QueryBuilder<LogEntity, LogEntity, QFilterCondition> {}

extension LogEntityQuerySortBy on QueryBuilder<LogEntity, LogEntity, QSortBy> {
  QueryBuilder<LogEntity, LogEntity, QAfterSortBy> sortByDisplayError() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayError', Sort.asc);
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterSortBy> sortByDisplayErrorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayError', Sort.desc);
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterSortBy> sortByDisplayException() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayException', Sort.asc);
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterSortBy>
      sortByDisplayExceptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayException', Sort.desc);
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterSortBy> sortByLogLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logLevel', Sort.asc);
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterSortBy> sortByLogLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logLevel', Sort.desc);
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterSortBy> sortByMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'message', Sort.asc);
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterSortBy> sortByMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'message', Sort.desc);
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterSortBy> sortByTextMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textMessage', Sort.asc);
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterSortBy> sortByTextMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textMessage', Sort.desc);
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterSortBy> sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterSortBy> sortByUpdate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'update', Sort.asc);
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterSortBy> sortByUpdateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'update', Sort.desc);
    });
  }
}

extension LogEntityQuerySortThenBy
    on QueryBuilder<LogEntity, LogEntity, QSortThenBy> {
  QueryBuilder<LogEntity, LogEntity, QAfterSortBy> thenByDisplayError() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayError', Sort.asc);
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterSortBy> thenByDisplayErrorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayError', Sort.desc);
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterSortBy> thenByDisplayException() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayException', Sort.asc);
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterSortBy>
      thenByDisplayExceptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayException', Sort.desc);
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterSortBy> thenByLogLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logLevel', Sort.asc);
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterSortBy> thenByLogLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logLevel', Sort.desc);
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterSortBy> thenByMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'message', Sort.asc);
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterSortBy> thenByMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'message', Sort.desc);
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterSortBy> thenByTextMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textMessage', Sort.asc);
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterSortBy> thenByTextMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textMessage', Sort.desc);
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterSortBy> thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterSortBy> thenByUpdate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'update', Sort.asc);
    });
  }

  QueryBuilder<LogEntity, LogEntity, QAfterSortBy> thenByUpdateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'update', Sort.desc);
    });
  }
}

extension LogEntityQueryWhereDistinct
    on QueryBuilder<LogEntity, LogEntity, QDistinct> {
  QueryBuilder<LogEntity, LogEntity, QDistinct> distinctByDisplayError(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'displayError', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LogEntity, LogEntity, QDistinct> distinctByDisplayException(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'displayException',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LogEntity, LogEntity, QDistinct> distinctByLogLevel(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'logLevel', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LogEntity, LogEntity, QDistinct> distinctByMessage(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'message', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LogEntity, LogEntity, QDistinct> distinctByTextMessage(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'textMessage', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LogEntity, LogEntity, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LogEntity, LogEntity, QDistinct> distinctByUpdate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'update');
    });
  }
}

extension LogEntityQueryProperty
    on QueryBuilder<LogEntity, LogEntity, QQueryProperty> {
  QueryBuilder<LogEntity, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<LogEntity, String?, QQueryOperations> displayErrorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'displayError');
    });
  }

  QueryBuilder<LogEntity, String?, QQueryOperations>
      displayExceptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'displayException');
    });
  }

  QueryBuilder<LogEntity, String?, QQueryOperations> logLevelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'logLevel');
    });
  }

  QueryBuilder<LogEntity, String?, QQueryOperations> messageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'message');
    });
  }

  QueryBuilder<LogEntity, String?, QQueryOperations> textMessageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'textMessage');
    });
  }

  QueryBuilder<LogEntity, String?, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }

  QueryBuilder<LogEntity, DateTime?, QQueryOperations> updateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'update');
    });
  }
}
