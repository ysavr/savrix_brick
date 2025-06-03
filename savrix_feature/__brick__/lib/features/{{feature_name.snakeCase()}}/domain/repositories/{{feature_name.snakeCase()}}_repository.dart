import 'package:dartz/dartz.dart';

import '../../data/models/{{feature_name.snakeCase()}}_dto.dart';

abstract class {{feature_name.pascalCase()}}Repository {
  Future<Either<String, {{feature_name.pascalCase()}}Dto>> searchPokemon({required String name});
}