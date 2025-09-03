import 'package:dartz/dartz.dart';
import 'package:ims_app/core/error/failures.dart';
import 'package:ims_app/features/{{FEATURE_NAME}}/domain/repositories/{{FEATURE_NAME}}_repository.dart';

class Delete{{ENTITY_PASCAL}}Usecase {
  final {{FEATURE_PASCAL}}Repository repository;

  Delete{{ENTITY_PASCAL}}Usecase(this.repository);

  Future<Either<Failure, Unit>> call(String id) {
    return repository.delete{{ENTITY_PASCAL}}(id);
  }
}