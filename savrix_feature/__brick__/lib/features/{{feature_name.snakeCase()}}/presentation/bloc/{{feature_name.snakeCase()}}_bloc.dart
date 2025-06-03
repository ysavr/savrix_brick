import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/{{feature_name.snakeCase()}}_entity.dart';
import '../../domain/usecase/{{feature_name.snakeCase()}}_usecase.dart';

part '{{feature_name.snakeCase()}}_event.dart';
part '{{feature_name.snakeCase()}}_state.dart';

class {{feature_name.pascalCase()}}Bloc extends Bloc<{{feature_name.pascalCase()}}Event, {{feature_name.pascalCase()}}State> {
  final {{feature_name.pascalCase()}}UseCase {{feature_name.camelCase()}}UseCase;

  {{feature_name.pascalCase()}}Bloc({required this.{{feature_name.camelCase()}}UseCase}) : super({{feature_name.pascalCase()}}Initial()) {
    on<{{feature_name.pascalCase()}}Event>((event, emit) async {
      if (event is SearchPokemonEvent) {
        emit({{feature_name.pascalCase()}}Loading());

        final result = await {{feature_name.camelCase()}}UseCase.searchPokemon(name: event.name);
        result.fold(
            (exception) => emit({{feature_name.pascalCase()}}ErrorState(appException: exception)),
            (entity) => emit({{feature_name.pascalCase()}}Result({{feature_name.camelCase()}}Entity: entity)));
      }
    });
  }
}
