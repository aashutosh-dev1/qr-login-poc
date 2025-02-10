// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qr_login.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GDeviceAuthVars> _$gDeviceAuthVarsSerializer =
    new _$GDeviceAuthVarsSerializer();
Serializer<GaddDeviceVars> _$gaddDeviceVarsSerializer =
    new _$GaddDeviceVarsSerializer();

class _$GDeviceAuthVarsSerializer
    implements StructuredSerializer<GDeviceAuthVars> {
  @override
  final Iterable<Type> types = const [GDeviceAuthVars, _$GDeviceAuthVars];
  @override
  final String wireName = 'GDeviceAuthVars';

  @override
  Iterable<Object?> serialize(Serializers serializers, GDeviceAuthVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'deviceId',
      serializers.serialize(object.deviceId,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GDeviceAuthVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GDeviceAuthVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'deviceId':
          result.deviceId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GaddDeviceVarsSerializer
    implements StructuredSerializer<GaddDeviceVars> {
  @override
  final Iterable<Type> types = const [GaddDeviceVars, _$GaddDeviceVars];
  @override
  final String wireName = 'GaddDeviceVars';

  @override
  Iterable<Object?> serialize(Serializers serializers, GaddDeviceVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'accessToken',
      serializers.serialize(object.accessToken,
          specifiedType: const FullType(String)),
      'refreshToken',
      serializers.serialize(object.refreshToken,
          specifiedType: const FullType(String)),
      'deviceId',
      serializers.serialize(object.deviceId,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.username;
    if (value != null) {
      result
        ..add('username')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GaddDeviceVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GaddDeviceVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'accessToken':
          result.accessToken = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'refreshToken':
          result.refreshToken = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'username':
          result.username = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'deviceId':
          result.deviceId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GDeviceAuthVars extends GDeviceAuthVars {
  @override
  final String deviceId;

  factory _$GDeviceAuthVars([void Function(GDeviceAuthVarsBuilder)? updates]) =>
      (new GDeviceAuthVarsBuilder()..update(updates))._build();

  _$GDeviceAuthVars._({required this.deviceId}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        deviceId, r'GDeviceAuthVars', 'deviceId');
  }

  @override
  GDeviceAuthVars rebuild(void Function(GDeviceAuthVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GDeviceAuthVarsBuilder toBuilder() =>
      new GDeviceAuthVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GDeviceAuthVars && deviceId == other.deviceId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, deviceId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GDeviceAuthVars')
          ..add('deviceId', deviceId))
        .toString();
  }
}

class GDeviceAuthVarsBuilder
    implements Builder<GDeviceAuthVars, GDeviceAuthVarsBuilder> {
  _$GDeviceAuthVars? _$v;

  String? _deviceId;
  String? get deviceId => _$this._deviceId;
  set deviceId(String? deviceId) => _$this._deviceId = deviceId;

  GDeviceAuthVarsBuilder();

  GDeviceAuthVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _deviceId = $v.deviceId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GDeviceAuthVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GDeviceAuthVars;
  }

  @override
  void update(void Function(GDeviceAuthVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GDeviceAuthVars build() => _build();

  _$GDeviceAuthVars _build() {
    final _$result = _$v ??
        new _$GDeviceAuthVars._(
          deviceId: BuiltValueNullFieldError.checkNotNull(
              deviceId, r'GDeviceAuthVars', 'deviceId'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GaddDeviceVars extends GaddDeviceVars {
  @override
  final String accessToken;
  @override
  final String refreshToken;
  @override
  final String? username;
  @override
  final String deviceId;

  factory _$GaddDeviceVars([void Function(GaddDeviceVarsBuilder)? updates]) =>
      (new GaddDeviceVarsBuilder()..update(updates))._build();

  _$GaddDeviceVars._(
      {required this.accessToken,
      required this.refreshToken,
      this.username,
      required this.deviceId})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        accessToken, r'GaddDeviceVars', 'accessToken');
    BuiltValueNullFieldError.checkNotNull(
        refreshToken, r'GaddDeviceVars', 'refreshToken');
    BuiltValueNullFieldError.checkNotNull(
        deviceId, r'GaddDeviceVars', 'deviceId');
  }

  @override
  GaddDeviceVars rebuild(void Function(GaddDeviceVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GaddDeviceVarsBuilder toBuilder() =>
      new GaddDeviceVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GaddDeviceVars &&
        accessToken == other.accessToken &&
        refreshToken == other.refreshToken &&
        username == other.username &&
        deviceId == other.deviceId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, accessToken.hashCode);
    _$hash = $jc(_$hash, refreshToken.hashCode);
    _$hash = $jc(_$hash, username.hashCode);
    _$hash = $jc(_$hash, deviceId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GaddDeviceVars')
          ..add('accessToken', accessToken)
          ..add('refreshToken', refreshToken)
          ..add('username', username)
          ..add('deviceId', deviceId))
        .toString();
  }
}

class GaddDeviceVarsBuilder
    implements Builder<GaddDeviceVars, GaddDeviceVarsBuilder> {
  _$GaddDeviceVars? _$v;

  String? _accessToken;
  String? get accessToken => _$this._accessToken;
  set accessToken(String? accessToken) => _$this._accessToken = accessToken;

  String? _refreshToken;
  String? get refreshToken => _$this._refreshToken;
  set refreshToken(String? refreshToken) => _$this._refreshToken = refreshToken;

  String? _username;
  String? get username => _$this._username;
  set username(String? username) => _$this._username = username;

  String? _deviceId;
  String? get deviceId => _$this._deviceId;
  set deviceId(String? deviceId) => _$this._deviceId = deviceId;

  GaddDeviceVarsBuilder();

  GaddDeviceVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _accessToken = $v.accessToken;
      _refreshToken = $v.refreshToken;
      _username = $v.username;
      _deviceId = $v.deviceId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GaddDeviceVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GaddDeviceVars;
  }

  @override
  void update(void Function(GaddDeviceVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GaddDeviceVars build() => _build();

  _$GaddDeviceVars _build() {
    final _$result = _$v ??
        new _$GaddDeviceVars._(
          accessToken: BuiltValueNullFieldError.checkNotNull(
              accessToken, r'GaddDeviceVars', 'accessToken'),
          refreshToken: BuiltValueNullFieldError.checkNotNull(
              refreshToken, r'GaddDeviceVars', 'refreshToken'),
          username: username,
          deviceId: BuiltValueNullFieldError.checkNotNull(
              deviceId, r'GaddDeviceVars', 'deviceId'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
