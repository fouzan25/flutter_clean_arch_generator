import 'package:equatable/equatable.dart';
import 'package:ims_app/features/{{FEATURE_NAME}}/domain/entities/{{ENTITY_NAME}}.dart';

abstract class {{FEATURE_PASCAL}}State extends Equatable {
  const {{FEATURE_PASCAL}}State();

  @override
  List<Object> get props => [];
}

class {{FEATURE_PASCAL}}Initial extends {{FEATURE_PASCAL}}State {
  const {{FEATURE_PASCAL}}Initial();
}

class {{FEATURE_PASCAL}}Loading extends {{FEATURE_PASCAL}}State {
  const {{FEATURE_PASCAL}}Loading();
}

class {{FEATURE_PASCAL}}ListLoaded extends {{FEATURE_PASCAL}}State {
  final List<{{ENTITY_PASCAL}}> {{ENTITY_CAMEL}}List;
  const {{FEATURE_PASCAL}}ListLoaded(this.{{ENTITY_CAMEL}}List);
  @override
  List<Object> get props => [{{ENTITY_CAMEL}}List];
}

class {{FEATURE_PASCAL}}Loaded extends {{FEATURE_PASCAL}}State {
  final {{ENTITY_PASCAL}} {{ENTITY_CAMEL}};
  const {{FEATURE_PASCAL}}Loaded(this.{{ENTITY_CAMEL}});
  @override
  List<Object> get props => [{{ENTITY_CAMEL}}];
}

class {{FEATURE_PASCAL}}Error extends {{FEATURE_PASCAL}}State {
  final String message;
  const {{FEATURE_PASCAL}}Error(this.message);
  @override
  List<Object> get props => [message];
}