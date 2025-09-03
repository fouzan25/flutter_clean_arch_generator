import 'package:injectable/injectable.dart';
import 'package:{{PACKAGE_NAME}}/core/network/http_client.dart';
import 'package:{{PACKAGE_NAME}}/features/{{FEATURE_NAME}}/data/models/{{ENTITY_NAME}}_model.dart';

abstract class {{FEATURE_PASCAL}}RemoteDataSource {
  Future<List<{{ENTITY_PASCAL}}Model>> get{{ENTITY_PASCAL}}List();
  Future<{{ENTITY_PASCAL}}Model> get{{ENTITY_PASCAL}}ById(String id);
  Future<{{ENTITY_PASCAL}}Model> create{{ENTITY_PASCAL}}(Map<String, dynamic> data);
  Future<{{ENTITY_PASCAL}}Model> update{{ENTITY_PASCAL}}(String id, Map<String, dynamic> data);
  Future<void> delete{{ENTITY_PASCAL}}(String id);
}

@LazySingleton(as: {{FEATURE_PASCAL}}RemoteDataSource)
class {{FEATURE_PASCAL}}RemoteDataSourceImpl implements {{FEATURE_PASCAL}}RemoteDataSource {
  final HttpClient httpClient;

  {{FEATURE_PASCAL}}RemoteDataSourceImpl({required this.httpClient});

  @override
  Future<List<{{ENTITY_PASCAL}}Model>> get{{ENTITY_PASCAL}}List() async {
    // TODO: Implement API call
    throw UnimplementedError();
  }

  @override
  Future<{{ENTITY_PASCAL}}Model> get{{ENTITY_PASCAL}}ById(String id) async {
    // TODO: Implement API call
    throw UnimplementedError();
  }

  @override
  Future<{{ENTITY_PASCAL}}Model> create{{ENTITY_PASCAL}}(Map<String, dynamic> data) async {
    // TODO: Implement API call
    throw UnimplementedError();
  }

  @override
  Future<{{ENTITY_PASCAL}}Model> update{{ENTITY_PASCAL}}(String id, Map<String, dynamic> data) async {
    // TODO: Implement API call
    throw UnimplementedError();
  }

  @override
  Future<void> delete{{ENTITY_PASCAL}}(String id) async {
    // TODO: Implement API call
    throw UnimplementedError();
  }
}