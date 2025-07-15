import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

class TimestampConverter implements JsonConverter<DateTime, String> {
  const TimestampConverter();

  @override
  DateTime fromJson(String json) => DateTime.parse(json);

  @override
  String toJson(DateTime date) => date.toIso8601String();
}

@freezed
abstract class UserModel with _$UserModel {
  factory UserModel({
    required String id,
    String? email,
    String? phoneNumber,
    @Default('Guest') String username,
    @Default('Male') String gender,
    String? profileImage,
    String? address,
    @TimestampConverter() DateTime? dateofBirth,
    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() required DateTime updatedAt,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  UserModel._() : super();

  Map<String, dynamic> toMap() {
    return {
      ...toJson(),
      'createdAt': const TimestampConverter().toJson(createdAt),
      'updatedAt': const TimestampConverter().toJson(updatedAt),
    };
  }
}
