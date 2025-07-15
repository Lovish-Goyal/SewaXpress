// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserModel {

 String get id; String? get email; String? get phoneNumber; String get username; String get gender; String? get profileImage; String? get address;@TimestampConverter() DateTime? get dateofBirth;@TimestampConverter() DateTime get createdAt;@TimestampConverter() DateTime get updatedAt;
/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserModelCopyWith<UserModel> get copyWith => _$UserModelCopyWithImpl<UserModel>(this as UserModel, _$identity);

  /// Serializes this UserModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserModel&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.username, username) || other.username == username)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.profileImage, profileImage) || other.profileImage == profileImage)&&(identical(other.address, address) || other.address == address)&&(identical(other.dateofBirth, dateofBirth) || other.dateofBirth == dateofBirth)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,email,phoneNumber,username,gender,profileImage,address,dateofBirth,createdAt,updatedAt);

@override
String toString() {
  return 'UserModel(id: $id, email: $email, phoneNumber: $phoneNumber, username: $username, gender: $gender, profileImage: $profileImage, address: $address, dateofBirth: $dateofBirth, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $UserModelCopyWith<$Res>  {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) _then) = _$UserModelCopyWithImpl;
@useResult
$Res call({
 String id, String? email, String? phoneNumber, String username, String gender, String? profileImage, String? address,@TimestampConverter() DateTime? dateofBirth,@TimestampConverter() DateTime createdAt,@TimestampConverter() DateTime updatedAt
});




}
/// @nodoc
class _$UserModelCopyWithImpl<$Res>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._self, this._then);

  final UserModel _self;
  final $Res Function(UserModel) _then;

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? email = freezed,Object? phoneNumber = freezed,Object? username = null,Object? gender = null,Object? profileImage = freezed,Object? address = freezed,Object? dateofBirth = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String,profileImage: freezed == profileImage ? _self.profileImage : profileImage // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,dateofBirth: freezed == dateofBirth ? _self.dateofBirth : dateofBirth // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [UserModel].
extension UserModelPatterns on UserModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserModel value)  $default,){
final _that = this;
switch (_that) {
case _UserModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserModel value)?  $default,){
final _that = this;
switch (_that) {
case _UserModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? email,  String? phoneNumber,  String username,  String gender,  String? profileImage,  String? address, @TimestampConverter()  DateTime? dateofBirth, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserModel() when $default != null:
return $default(_that.id,_that.email,_that.phoneNumber,_that.username,_that.gender,_that.profileImage,_that.address,_that.dateofBirth,_that.createdAt,_that.updatedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? email,  String? phoneNumber,  String username,  String gender,  String? profileImage,  String? address, @TimestampConverter()  DateTime? dateofBirth, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _UserModel():
return $default(_that.id,_that.email,_that.phoneNumber,_that.username,_that.gender,_that.profileImage,_that.address,_that.dateofBirth,_that.createdAt,_that.updatedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? email,  String? phoneNumber,  String username,  String gender,  String? profileImage,  String? address, @TimestampConverter()  DateTime? dateofBirth, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _UserModel() when $default != null:
return $default(_that.id,_that.email,_that.phoneNumber,_that.username,_that.gender,_that.profileImage,_that.address,_that.dateofBirth,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserModel extends UserModel {
   _UserModel({required this.id, this.email, this.phoneNumber, this.username = 'Guest', this.gender = 'Male', this.profileImage, this.address, @TimestampConverter() this.dateofBirth, @TimestampConverter() required this.createdAt, @TimestampConverter() required this.updatedAt}): super._();
  factory _UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

@override final  String id;
@override final  String? email;
@override final  String? phoneNumber;
@override@JsonKey() final  String username;
@override@JsonKey() final  String gender;
@override final  String? profileImage;
@override final  String? address;
@override@TimestampConverter() final  DateTime? dateofBirth;
@override@TimestampConverter() final  DateTime createdAt;
@override@TimestampConverter() final  DateTime updatedAt;

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserModelCopyWith<_UserModel> get copyWith => __$UserModelCopyWithImpl<_UserModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserModel&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.username, username) || other.username == username)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.profileImage, profileImage) || other.profileImage == profileImage)&&(identical(other.address, address) || other.address == address)&&(identical(other.dateofBirth, dateofBirth) || other.dateofBirth == dateofBirth)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,email,phoneNumber,username,gender,profileImage,address,dateofBirth,createdAt,updatedAt);

@override
String toString() {
  return 'UserModel(id: $id, email: $email, phoneNumber: $phoneNumber, username: $username, gender: $gender, profileImage: $profileImage, address: $address, dateofBirth: $dateofBirth, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$UserModelCopyWith<$Res> implements $UserModelCopyWith<$Res> {
  factory _$UserModelCopyWith(_UserModel value, $Res Function(_UserModel) _then) = __$UserModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String? email, String? phoneNumber, String username, String gender, String? profileImage, String? address,@TimestampConverter() DateTime? dateofBirth,@TimestampConverter() DateTime createdAt,@TimestampConverter() DateTime updatedAt
});




}
/// @nodoc
class __$UserModelCopyWithImpl<$Res>
    implements _$UserModelCopyWith<$Res> {
  __$UserModelCopyWithImpl(this._self, this._then);

  final _UserModel _self;
  final $Res Function(_UserModel) _then;

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? email = freezed,Object? phoneNumber = freezed,Object? username = null,Object? gender = null,Object? profileImage = freezed,Object? address = freezed,Object? dateofBirth = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_UserModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String,profileImage: freezed == profileImage ? _self.profileImage : profileImage // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,dateofBirth: freezed == dateofBirth ? _self.dateofBirth : dateofBirth // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
