import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce/core/errors/failure.dart';
import 'package:e_commerce/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:e_commerce/features/auth/domain/entities/user.dart';
import 'package:e_commerce/features/auth/domain/repositories/auth_repositories.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, User>> login(
      String username, String password, bool rememberMe) async {
    try {
      final result =
          await remoteDataSource.login(username, password, rememberMe);
      return Right(result);
    } on DioException catch (e) {
      // Handle specific Dio errors for better user feedback
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionError) {
        return Left(Failure('Network error. Please check your connection.'));
      }

      // Handle errors from the server response (e.g., 400, 401, 500)
      if (e.response != null) {
        final errorMessage = e.response?.data['message'] as String? ??
            'Invalid username or password.';
        return Left(Failure(errorMessage));
      }

      // Fallback for other Dio errors
      return Left(Failure('An unexpected API error occurred.'));
    } catch (e) {
      return Left(Failure('Oops, something went wrong: ${e.toString()}'));
    }
  }
}
