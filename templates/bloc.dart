import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:ims_app/features/{{FEATURE_NAME}}/domain/usecases/get_{{ENTITY_NAME}}_usecase.dart';
import 'package:ims_app/features/{{FEATURE_NAME}}/domain/usecases/create_{{ENTITY_NAME}}_usecase.dart';
import 'package:ims_app/features/{{FEATURE_NAME}}/domain/usecases/update_{{ENTITY_NAME}}_usecase.dart';
import 'package:ims_app/features/{{FEATURE_NAME}}/domain/usecases/delete_{{ENTITY_NAME}}_usecase.dart';
import 'package:ims_app/features/{{FEATURE_NAME}}/presentation/bloc/{{FEATURE_NAME}}/{{FEATURE_NAME}}_event.dart';
import 'package:ims_app/features/{{FEATURE_NAME}}/presentation/bloc/{{FEATURE_NAME}}/{{FEATURE_NAME}}_state.dart';

@lazySingleton
class {{FEATURE_PASCAL}}Bloc extends Bloc<{{FEATURE_PASCAL}}Event, {{FEATURE_PASCAL}}State> {
  final Get{{ENTITY_PASCAL}}Usecase get{{ENTITY_PASCAL}}Usecase;
  final Create{{ENTITY_PASCAL}}Usecase create{{ENTITY_PASCAL}}Usecase;
  final Update{{ENTITY_PASCAL}}Usecase update{{ENTITY_PASCAL}}Usecase;
  final Delete{{ENTITY_PASCAL}}Usecase delete{{ENTITY_PASCAL}}Usecase;

  {{FEATURE_PASCAL}}Bloc({
    required this.get{{ENTITY_PASCAL}}Usecase,
    required this.create{{ENTITY_PASCAL}}Usecase,
    required this.update{{ENTITY_PASCAL}}Usecase,
    required this.delete{{ENTITY_PASCAL}}Usecase,
  }) : super(const {{FEATURE_PASCAL}}Initial()) {
    on<{{FEATURE_PASCAL}}LoadList>(_onLoadList);
    on<{{FEATURE_PASCAL}}LoadById>(_onLoadById);
    on<{{FEATURE_PASCAL}}Create>(_onCreate);
    on<{{FEATURE_PASCAL}}Update>(_onUpdate);
    on<{{FEATURE_PASCAL}}Delete>(_onDelete);
  }

  Future<void> _onLoadList({{FEATURE_PASCAL}}LoadList event, Emitter<{{FEATURE_PASCAL}}State> emit) async {
    // TODO: Implement load list logic
  }

  Future<void> _onLoadById({{FEATURE_PASCAL}}LoadById event, Emitter<{{FEATURE_PASCAL}}State> emit) async {
    // TODO: Implement load by id logic
  }

  Future<void> _onCreate({{FEATURE_PASCAL}}Create event, Emitter<{{FEATURE_PASCAL}}State> emit) async {
    // TODO: Implement create logic
  }

  Future<void> _onUpdate({{FEATURE_PASCAL}}Update event, Emitter<{{FEATURE_PASCAL}}State> emit) async {
    // TODO: Implement update logic
  }

  Future<void> _onDelete({{FEATURE_PASCAL}}Delete event, Emitter<{{FEATURE_PASCAL}}State> emit) async {
    // TODO: Implement delete logic
  }
}