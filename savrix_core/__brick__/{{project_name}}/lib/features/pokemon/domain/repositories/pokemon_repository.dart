import 'package:{{project_name.snakeCase()}}/core/data/model/exception.dart';
import 'package:{{project_name.snakeCase()}}/features/pokemon/data/models/pokemon_dto.dart';
import 'package:dartz/dartz.dart';

abstract class PokemonRepository {
  Future<Either<AppException, PokemonDto>> searchPokemon({required String name});
}