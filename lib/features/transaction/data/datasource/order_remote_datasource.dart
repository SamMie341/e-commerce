import 'package:dio/dio.dart';
import 'package:e_commerce/core/services/dio_config.dart';
import 'package:e_commerce/core/utils/constant.dart';
import 'package:e_commerce/features/transaction/data/model/order_detail_model.dart';

abstract class OrderRemoteDatasource {
  Future<List<OrderDetailModel>> fetchOrder();

  Future<List<OrderDetailModel>> fetchOrderProcess();

  Future<List<OrderDetailModel>> fetchOrderCancel();

  Future<OrderDetailModel> fetchOrderById(int id);

  Future<void> deleteOrder(int id);
}

class OrderRemoteDataSourceImpl implements OrderRemoteDatasource {
  final Dio _dio = DioConfig.dioWithAuth;

  @override
  Future<List<OrderDetailModel>> fetchOrder() async {
    try {
      final response = await _dio.get('/api/orderlist');
      if (response.statusCode == 200) {
        final List jsonList = response.data;
        final jsonData =
            jsonList.map((json) => OrderDetailModel.fromJson(json)).toList();
        // return Right(jsonData);
        return jsonData;
      } else {
        final message = response.data['message'];
        // return Left(Failure(message ?? 'ບໍ່ສາມາດສະແດງລາຍການສັ່ງຊື້'));
        return message;
      }
    } on Exception catch (e) {
      // return Left(Failure(e.message ?? 'An Error Occurred'));
      throw Exception(e);
    }
  }

  @override
  Future<List<OrderDetailModel>> fetchOrderProcess() async {
    try {
      final response = await _dio.get('/api/orderprocess');
      if (response.statusCode == 200) {
        final List jsonList = response.data;
        final jsonData =
            jsonList.map((json) => OrderDetailModel.fromJson(json)).toList();
        // return Right(jsonData);
        return jsonData;
      } else {
        final message = response.data['message'];
        // return Left(Failure(message ?? 'ບໍ່ສາມາດສະແດງລາຍການດຳເນີນການ'));
        return message;
      }
    } on DioException catch (e) {
      // return Left(Failure(e.message ?? 'An Error Occurred'));
      throw Exception(e);
    }
  }

  @override
  Future<List<OrderDetailModel>> fetchOrderCancel() async {
    try {
      final response = await _dio.get('/api/ordercancle');
      if (response.statusCode == 200) {
        final List jsonList = response.data;
        final jsonData =
            jsonList.map((json) => OrderDetailModel.fromJson(json)).toList();
        // return Right(jsonData);
        return jsonData;
      } else {
        final message = response.data['message'];
        // return Left(Failure(message ?? 'ບໍ່ສາມາດສະແດງລາຍການຍົກເລີກ'));
        return message;
      }
    } on DioException catch (e) {
      // return Left(Failure(e.message ?? 'An Error Occurred'));
      throw Exception(e);
    }
  }

  @override
  Future<OrderDetailModel> fetchOrderById(int id) async {
    final response = await _dio.get('/api/orders/$id');
    final Map<String, dynamic> jsonList = response.data;
    return OrderDetailModel.fromJson(jsonList);
  }

  @override
  Future<void> deleteOrder(int id) async {
    final response = await _dio.delete('$apiUrl/api/orders/$id');
    if (response.statusCode != 200) {
      throw Exception("Failed to delete product");
    }
  }
}
