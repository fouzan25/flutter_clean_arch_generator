import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:ims_app/core/error/failures.dart';
import 'package:ims_app/features/{{FEATURE_NAME}}/domain/entities/{{ENTITY_NAME}}.dart';
import 'package:ims_app/features/{{FEATURE_NAME}}/domain/repositories/{{FEATURE_NAME}}_repository.dart';

class Update{{ENTITY_PASCAL}}Usecase {
  final {{FEATURE_PASCAL}}Repository repository;

  Update{{ENTITY_PASCAL}}Usecase(this.repository);

  Future<Either<Failure, {{ENTITY_PASCAL}}>> call(String id, {{ENTITY_PASCAL}}UpdateParams params) {
    return repository.update{{ENTITY_PASCAL}}(id, params);
  }
}

class {{ENTITY_PASCAL}}UpdateParams extends Equatable {
  final String? name;

  const {{ENTITY_PASCAL}}UpdateParams({this.name});

  @override
  List<Object?> get props => [name];
}