import 'package:dartz/dartz.dart';
import 'package:ims_app/core/error/failures.dart';
import 'package:ims_app/features/{{FEATURE_NAME}}/domain/entities/{{ENTITY_NAME}}.dart';
import 'package:ims_app/features/{{FEATURE_NAME}}/domain/repositories/{{FEATURE_NAME}}_repository.dart';

class Get{{ENTITY_PASCAL}}Usecase {
  final {{FEATURE_PASCAL}}Repository repository;

  Get{{ENTITY_PASCAL}}Usecase(this.repository);

  Future<Either<Failure, {{ENTITY_PASCAL}}>> call(String id) {
    return repository.get{{ENTITY_PASCAL}}ById(id);
  }
}