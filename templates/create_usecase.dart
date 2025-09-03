import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:ims_app/core/error/failures.dart';
import 'package:ims_app/features/{{FEATURE_NAME}}/domain/entities/{{ENTITY_NAME}}.dart';
import 'package:ims_app/features/{{FEATURE_NAME}}/domain/repositories/{{FEATURE_NAME}}_repository.dart';

class Create{{ENTITY_PASCAL}}Usecase {
  final {{FEATURE_PASCAL}}Repository repository;

  Create{{ENTITY_PASCAL}}Usecase(this.repository);

  Future<Either<Failure, {{ENTITY_PASCAL}}>> call({{ENTITY_PASCAL}}CreateParams params) {
    return repository.create{{ENTITY_PASCAL}}(params);
  }
}

class {{ENTITY_PASCAL}}CreateParams extends Equatable {
  final String name;

  const {{ENTITY_PASCAL}}CreateParams({required this.name});

  @override
  List<Object> get props => [name];
}