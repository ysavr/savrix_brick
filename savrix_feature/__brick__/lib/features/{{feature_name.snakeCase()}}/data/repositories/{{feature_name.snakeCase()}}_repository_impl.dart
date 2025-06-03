import 'dart:io';

import '../../domain/repositories/{{feature_name.snakeCase()}}_repository.dart';
import '../models/{{feature_name.snakeCase()}}_dto.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class {{feature_name.pascalCase()}}RepositoryImpl extends {{feature_name.pascalCase()}}Repository {
  final Dio dio;

  {{feature_name.pascalCase()}}RepositoryImpl({required this.dio});

  @override
  Future<Either<String, {{feature_name.pascalCase()}}Dto>> searchPokemon(
      {required String name}) async {
    try {
      final response = await dio.get("/pokemon/$name");
      return Right({{feature_name.pascalCase()}}Dto.fromJson(response.data));
    } on DioException catch (error) {
      if (error.type == DioExceptionType.connectionError) {
        return Left('Failed to connect to server');
      }
      return Left('Failed to get data');
    } on SocketException {
      return Left('No internet connection');
    } catch (e) {
      return Left('An unexpected error occurred');
    }
  }
}