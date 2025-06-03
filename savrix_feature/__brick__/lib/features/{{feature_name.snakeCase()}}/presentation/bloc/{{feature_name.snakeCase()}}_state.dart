part of '{{feature_name.snakeCase()}}_bloc.dart';

abstract class {{feature_name.pascalCase()}}State {}

final class {{feature_name.pascalCase()}}Initial extends {{feature_name.pascalCase()}}State {}

class {{feature_name.pascalCase()}}Loading extends {{feature_name.pascalCase()}}State {}

class {{feature_name.pascalCase()}}ErrorState extends {{feature_name.pascalCase()}}State {
  final String appException;

  {{feature_name.pascalCase()}}ErrorState({required this.appException});
}

class {{feature_name.pascalCase()}}Result extends {{feature_name.pascalCase()}}State {
  final {{feature_name.pascalCase()}}Entity {{feature_name.camelCase()}}Entity;

  {{feature_name.pascalCase()}}Result({required this.{{feature_name.camelCase()}}Entity});
}
