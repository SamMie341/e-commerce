import 'package:e_commerce/features/product/data/datasource/review_remote_datasource.dart';
import 'package:e_commerce/features/product/data/model/review_model.dart';
import 'package:e_commerce/features/product/domain/repositories/review_repository.dart';

class ReviewRepositoryImpl implements ReviewRepository {
  final ReviewRemoteDatasource remoteDataSource;

  ReviewRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Review>> fetchReview(int productId) async {
    return await remoteDataSource.fetchReview(productId);
  }
}
