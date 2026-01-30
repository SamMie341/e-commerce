import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce/core/errors/failure.dart';
import 'package:e_commerce/features/home/data/models/product_model.dart';
import 'package:e_commerce/features/reviews/data/datasource/review_detail_remote.dart';
import 'package:e_commerce/features/reviews/data/model/review_by_product_model.dart';
import 'package:e_commerce/features/reviews/data/model/review_model.dart';

abstract class ReviewDetailRepository {
  Future<List<ReviewModel>> fetchReview({int page = 1, int limit = 10});

  Future<ProductModel> fetchReviewById(int id);

  Future<Either<Failure, void>> postReview(
      int productId, int rating, String comment);
  Future<Either<Failure, List<ReviewByProductModel>>> fetchReviewByPro(
      int productId);
  Future<Either<Failure, void>> updateReview(
      int reviewId, int productId, int rating, String comment);
  Future<Either<Failure, void>> deleteReview(int reviewId);
}

class ReviewDetailRepositoryImpl implements ReviewDetailRepository {
  final ReviewDetailRemoteDatasource remote;
  ReviewDetailRepositoryImpl(this.remote);

  @override
  Future<List<ReviewModel>> fetchReview({int page = 1, int limit = 10}) async {
    return await remote.fetchReview(page: page, limit: limit);
  }

  @override
  Future<ProductModel> fetchReviewById(int id) async {
    return await remote.fetchReviewById(id);
  }

  @override
  Future<Either<Failure, void>> postReview(
      int productId, int rating, String comment) async {
    try {
      final result = await remote.postReview(productId, rating, comment);
      return Right(result);
    } on DioException catch (e) {
      if (e.response?.statusCode == 409) {
        final message = 'ທ່ານຣີວິວສິນຄ້າແລ້ວ ບໍ່ສາມາດຣີວິວໄດ້ອີກ';
        return Left(Failure(message));
      }
      return Left(Failure('An API Error'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ReviewByProductModel>>> fetchReviewByPro(
      int productId) async {
    try {
      final result = await remote.fetchReviewByPro(productId);
      return Right(result);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteReview(int reviewId) async {
    try {
      await remote.deleteReview(reviewId);
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateReview(
      int reviewId, int productId, int rating, String comment) async {
    try {
      await remote.updateReview(reviewId, productId, rating, comment);
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
