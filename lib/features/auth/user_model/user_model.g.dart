// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserModel _$UserModelFromJson(Map<String, dynamic> json) => _UserModel(
  id: json['id'] as String,
  email: json['email'] as String?,
  phoneNumber: json['phoneNumber'] as String?,
  username: json['username'] as String? ?? 'Guest',
  gender: json['gender'] as String? ?? 'Male',
  profileImage: json['profileImage'] as String?,
  address: json['address'] as String?,
  dateofBirth: _$JsonConverterFromJson<String, DateTime>(
    json['dateofBirth'],
    const TimestampConverter().fromJson,
  ),
  createdAt: const TimestampConverter().fromJson(json['createdAt'] as String),
  updatedAt: const TimestampConverter().fromJson(json['updatedAt'] as String),
);

Map<String, dynamic> _$UserModelToJson(_UserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'username': instance.username,
      'gender': instance.gender,
      'profileImage': instance.profileImage,
      'address': instance.address,
      'dateofBirth': _$JsonConverterToJson<String, DateTime>(
        instance.dateofBirth,
        const TimestampConverter().toJson,
      ),
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);
