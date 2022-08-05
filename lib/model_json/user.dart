import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  const User({
    required this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  final String id;

  Map<String, dynamic> toJson() => _$UserToJson(this);

  User copyWith({
    String? id,
  }) =>
      User(
        id: id ?? this.id,
      );

  @override
  List<Object?> get props => [
        id,
      ];
}