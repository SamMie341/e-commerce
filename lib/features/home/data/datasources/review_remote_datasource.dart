import 'package:e_commerce/core/services/dio_config.dart';
import 'package:e_commerce/core/utils/constant.dart';
import 'package:e_commerce/features/product/data/model/review_model.dart';

class ReviewRemoteDatasource {
  final DioConfig dioConfig;
  ReviewRemoteDatasource(this.dioConfig);

  Future<List<Review>> fetchReview(int productId) async {
    final response = await DioConfig.dioWithAuth
        .get('$apiUrl/api/reviews?productId=$productId');

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = response.data;
      return jsonList.map((json) => Review.fromJson(json)).toList();
    } else {
      print(Exception());
      throw Exception('Fail to load Review');
    }
  }
}
