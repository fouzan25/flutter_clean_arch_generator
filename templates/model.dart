import 'package:json_annotation/json_annotation.dart';
import 'package:ims_app/features/{{FEATURE_NAME}}/domain/entities/{{ENTITY_NAME}}.dart';

part '{{ENTITY_NAME}}_model.g.dart';

@JsonSerializable()
class {{ENTITY_PASCAL}}Model {
  final String id;
  final String name;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'updated_at')
  final String updatedAt;

  const {{ENTITY_PASCAL}}Model({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory {{ENTITY_PASCAL}}Model.fromJson(Map<String, dynamic> json) => 
      _${{ENTITY_PASCAL}}ModelFromJson(json);

  Map<String, dynamic> toJson() => _${{ENTITY_PASCAL}}ModelToJson(this);

  {{ENTITY_PASCAL}} toEntity() {
    return {{ENTITY_PASCAL}}(
      id: id,
      name: name,
      createdAt: DateTime.parse(createdAt),
      updatedAt: DateTime.parse(updatedAt),
    );
  }
}