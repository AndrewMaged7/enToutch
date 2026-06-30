import 'package:dio/dio.dart';
import 'package:en_touch/core/api/end_points.dart';
import 'package:en_touch/core/cache/hive_cach_helper.dart';
import 'package:en_touch/core/services/app_services.dart';
import 'package:en_touch/features/auth/data/models/auth_model.dart';

class ApiManager {
  late Dio dio;
  EndPoints endPoints = EndPoints();
  AppServices appServices = AppServices();
  ApiManager() {
    dio = Dio(
      BaseOptions(
        baseUrl: endPoints.baseUrl,
        followRedirects: false,
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
        receiveDataWhenStatusError: true,
        validateStatus: (status) {
          if (status == null) return false;
          if (status == 401) return false;
          return status >= 200 && status < 500;
        },
      ),
    );
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          AuthModel? auth = HiveCacheHelper.getData<AuthModel>('authData');
          if (auth?.token != null) {
            options.headers['Authorization'] = 'Bearer ${auth!.token}';
          }
          return handler.next(options);
        },
        onError: (error, handler) async {
  final statusCode = error.response?.statusCode;
  if (statusCode == 401) {
    try {
      bool refreshSuccess = await appServices.refreshToken();
      if (!refreshSuccess) {
        return handler.next(error);
      }

      final auth = HiveCacheHelper.getData<AuthModel>('authData');
      final requestOptions = error.requestOptions;
      requestOptions.headers['Authorization'] = "Bearer ${auth?.token}";
      if (requestOptions.data is FormData) {
        final filePath = requestOptions.extra['filePath'] as String?;
        final fileKey = requestOptions.extra['fileKey'] as String? ?? 'file';
        
        if (filePath != null) {
          requestOptions.data = FormData.fromMap({
            fileKey: MultipartFile.fromFileSync(
              filePath,
              filename: filePath.split('/').last,
            ),
          });
        }
      }

      final response = await dio.fetch(requestOptions);
      return handler.resolve(response);
    } catch (e) {
      print('Refresh exception: $e');
    }
  }
  return handler.next(error);
},
      ),
    );
  }

  Future<Response> post({
  required String endPoint,
  dynamic data,
  Map<String, dynamic>? extra,
}) async {
  return await dio.post(
    endPoint,
    data: data,
    options: Options(
      contentType: data is FormData ? 'multipart/form-data' : 'application/json',
      extra: extra,
    ),
  );
}

  Future<Response> get({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await dio.get(endPoint, queryParameters: queryParameters);
  }

  Future<Response> put({
    required String endPoint,
    Map<String, dynamic>? data,
  }) async {
    return await dio.put(endPoint, data: data);
  }

  Future<Response> delete({
    required String endPoint,
    Map<String, dynamic>? data,
  }) async {
    return await dio.delete(endPoint, data: data);
  }
}
