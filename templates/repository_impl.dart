import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:ims_app/core/error/failures.dart';
import 'package:ims_app/features/{{FEATURE_NAME}}/domain/entities/{{ENTITY_NAME}}.dart';
import 'package:ims_app/features/{{FEATURE_NAME}}/domain/repositories/{{FEATURE_NAME}}_repository.dart';
import 'package:ims_app/features/{{FEATURE_NAME}}/data/datasources/{{FEATURE_NAME}}_remote_datasource.dart';
import 'package:ims_app/features/{{FEATURE_NAME}}/domain/usecases/create_{{ENTITY_NAME}}_usecase.dart';
import 'package:ims_app/features/{{FEATURE_NAME}}/domain/usecases/update_{{ENTITY_NAME}}_usecase.dart';

@LazySingleton(as: {{FEATURE_PASCAL}}Repository)
class {{FEATURE_PASCAL}}RepositoryImpl implements {{FEATURE_PASCAL}}Repository {
  final {{FEATURE_PASCAL}}RemoteDataSource remoteDataSource;

  {{FEATURE_PASCAL}}RepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<{{ENTITY_PASCAL}}>>> get{{ENTITY_PASCAL}}List() async {
    // TODO: Implement with error handling
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, {{ENTITY_PASCAL}}>> get{{ENTITY_PASCAL}}ById(String id) async {
    // TODO: Implement with error handling
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, {{ENTITY_PASCAL}}>> create{{ENTITY_PASCAL}}({{ENTITY_PASCAL}}CreateParams params) async {
    // TODO: Implement with error handling
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, {{ENTITY_PASCAL}}>> update{{ENTITY_PASCAL}}(String id, {{ENTITY_PASCAL}}UpdateParams params) async {
    // TODO: Implement with error handling
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> delete{{ENTITY_PASCAL}}(String id) async {
    // TODO: Implement with error handling
    throw UnimplementedError();
  }
}