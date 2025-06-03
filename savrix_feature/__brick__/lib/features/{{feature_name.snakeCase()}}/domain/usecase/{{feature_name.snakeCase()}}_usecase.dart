import '../../data/models/{{feature_name.snakeCase()}}_dto.dart';
import '../entities/{{feature_name.snakeCase()}}_entity.dart';
import '../repositories/{{feature_name.snakeCase()}}_repository.dart';
import 'package:dartz/dartz.dart';

class {{feature_name.pascalCase()}}UseCase {
  final {{feature_name.pascalCase()}}Repository {{feature_name.camelCase()}}Repository;

  {{feature_name.pascalCase()}}UseCase({required this.{{feature_name.camelCase()}}Repository});

  Future<Either<String, {{feature_name.pascalCase()}}Entity>> searchPokemon(
      {required String name}) async {
    final result =
    await {{feature_name.camelCase()}}Repository.searchPokemon(name: name.toLowerCase());

    return result.fold(
          (exception) => Left(exception),
          (data) => Right({{feature_name.pascalCase()}}Entity(
          name: data.name ?? "-",
          image: data.sprites?.other?.home?.frontDefault ?? "",
          weight: data.weight ?? 0)),
    );
  }
}