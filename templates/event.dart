import 'package:equatable/equatable.dart';
import 'package:ims_app/features/{{FEATURE_NAME}}/domain/usecases/create_{{ENTITY_NAME}}_usecase.dart';
import 'package:ims_app/features/{{FEATURE_NAME}}/domain/usecases/update_{{ENTITY_NAME}}_usecase.dart';

abstract class {{FEATURE_PASCAL}}Event extends Equatable {
  const {{FEATURE_PASCAL}}Event();

  @override
  List<Object> get props => [];
}

class {{FEATURE_PASCAL}}LoadList extends {{FEATURE_PASCAL}}Event {
  const {{FEATURE_PASCAL}}LoadList();
}

class {{FEATURE_PASCAL}}LoadById extends {{FEATURE_PASCAL}}Event {
  final String id;
  const {{FEATURE_PASCAL}}LoadById(this.id);
  @override
  List<Object> get props => [id];
}

class {{FEATURE_PASCAL}}Create extends {{FEATURE_PASCAL}}Event {
  final {{ENTITY_PASCAL}}CreateParams params;
  const {{FEATURE_PASCAL}}Create(this.params);
  @override
  List<Object> get props => [params];
}

class {{FEATURE_PASCAL}}Update extends {{FEATURE_PASCAL}}Event {
  final String id;
  final {{ENTITY_PASCAL}}UpdateParams params;
  const {{FEATURE_PASCAL}}Update(this.id, this.params);
  @override
  List<Object> get props => [id, params];
}

class {{FEATURE_PASCAL}}Delete extends {{FEATURE_PASCAL}}Event {
  final String id;
  const {{FEATURE_PASCAL}}Delete(this.id);
  @override
  List<Object> get props => [id];
}