import 'package:equatable/equatable.dart';

class {{ENTITY_PASCAL}} extends Equatable {
  final String id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;

  const {{ENTITY_PASCAL}}({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object> get props => [id, name, createdAt, updatedAt];
}