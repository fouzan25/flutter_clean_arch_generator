import 'package:dartz/dartz.dart';
import 'package:{{PACKAGE_NAME}}/core/error/failures.dart';
import 'package:{{PACKAGE_NAME}}/features/{{FEATURE_NAME}}/domain/entities/{{ENTITY_NAME}}.dart';
import 'package:{{PACKAGE_NAME}}/features/{{FEATURE_NAME}}/domain/usecases/create_{{ENTITY_NAME}}_usecase.dart';
import 'package:{{PACKAGE_NAME}}/features/{{FEATURE_NAME}}/domain/usecases/update_{{ENTITY_NAME}}_usecase.dart';

abstract class {{FEATURE_PASCAL}}Repository {
  Future<Either<Failure, List<{{ENTITY_PASCAL}}>>> get{{ENTITY_PASCAL}}List();
  Future<Either<Failure, {{ENTITY_PASCAL}}>> get{{ENTITY_PASCAL}}ById(String id);
  Future<Either<Failure, {{ENTITY_PASCAL}}>> create{{ENTITY_PASCAL}}({{ENTITY_PASCAL}}CreateParams params);
  Future<Either<Failure, {{ENTITY_PASCAL}}>> update{{ENTITY_PASCAL}}(String id, {{ENTITY_PASCAL}}UpdateParams params);
  Future<Either<Failure, Unit>> delete{{ENTITY_PASCAL}}(String id);
}