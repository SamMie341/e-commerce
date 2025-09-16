import 'package:dio/dio.dart';
import 'package:e_commerce/core/utils/constant.dart';
import 'package:e_commerce/core/utils/utility.dart';
import 'package:get/get.dart';

class DioConfig {
  static late String access_token;

  static getToken() async {
    access_token = Utility.getSharedPreference('token');
  }

  static final Dio _dio = Dio()
    ..interceptors.add(
      InterceptorsWrapper(onRequest: (options, handler) async {
        options.headers['Accept'] = 'application/json';
        options.headers['Content-Type'] = 'application/json';
        options.baseUrl = apiUrl;
        options.connectTimeout = const Duration(seconds: 30);
        options.sendTimeout = const Duration(seconds: 30);
        options.receiveTimeout = const Duration(seconds: 90);
        return handler.next(options);
      }, onResponse: (response, handler) async {
        return handler.next(response);
      }, onError: (DioException e, handler) async {
        switch (e.response?.statusCode) {
          case 400:
            Utility().logger.e('Bad Request');
            break;
          case 401:
            Utility().logger.e('UnAuthorization');
            break;
          case 403:
            Utility().logger.e('Forbidden');
            break;
          case 404:
            Utility().logger.e('Not Found');
            break;
          case 500:
            Utility().logger.e('Internal Server Error');
            break;
          default:
            Utility().logger.e('Something went wrong');
            break;
        }
      }),
    );

  static final Dio _dio2 = Dio()
    ..interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          options.headers['Accept'] = 'application/json';
          options.headers['Content-Type'] = 'application/json';
          options.baseUrl = apiUrl;
          options.connectTimeout = const Duration(seconds: 30);
          options.sendTimeout = const Duration(seconds: 30);
          options.receiveTimeout = const Duration(seconds: 90);
          return handler.next(options);
        },
        onResponse: (response, handler) async {
          return handler.next(response);
        },
        onError: (DioException e, handler) async {
          switch (e.response?.statusCode) {
            case 400:
              Utility().logger.e('Bad Request');
              break;
            case 401:
              Utility().logger.e('UnAuthorization');
              Get.offAll('/');
              break;
            case 403:
              Utility().logger.e('Forbidden');
              break;
            case 404:
              Utility().logger.e('Not Found');
              break;
            case 500:
              Utility().logger.e('Internal Server Error');
              break;
            default:
              Utility().logger.e('Something went wrong');
              break;
          }
          return handler.next(e);
        },
      ),
    );

  static final Dio _dioWithAuth = Dio()
    ..interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          await getToken();
          options.headers['Authorization'] = 'Bearer $access_token';
          options.headers['Accept'] = 'application/json';
          options.headers['Content-Type'] = 'application/json';
          options.baseUrl = apiUrl;
          options.connectTimeout = const Duration(seconds: 30);
          options.sendTimeout = const Duration(seconds: 30);
          options.receiveTimeout = const Duration(seconds: 90);
          return handler.next(options);
        },
        onResponse: (response, handler) async {
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          switch (e.response?.statusCode) {
            case 400:
              Utility().logger.e('Bad Request');
              break;
            case 401:
              Utility().logger.e('UnAuthorization');
              break;
            case 403:
              Utility().logger.e('Forbidden');
              break;
            case 404:
              Utility().logger.e('Not Found');
              break;
            case 500:
              Utility().logger.e('Internal Server Error');
              break;
            default:
              Utility().logger.e('Something went wrong');
              break;
          }
          return handler.next(e);
        },
      ),
    );

  static Dio get dio => _dio;
  static Dio get dio2 => _dio2;
  static Dio get dioWithAuth => _dioWithAuth;
}
