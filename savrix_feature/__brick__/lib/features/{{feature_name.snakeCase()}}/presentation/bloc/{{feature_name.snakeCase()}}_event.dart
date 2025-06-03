part of '{{feature_name.snakeCase()}}_bloc.dart';

abstract class {{feature_name.pascalCase()}}Event {}

class SearchPokemonEvent extends {{feature_name.pascalCase()}}Event {
  final String name;

  SearchPokemonEvent({
    required this.name,
  });
}
