import 'package:dio/dio.dart';
import 'api_constants.dart';

class DioHelper {
  DioHelper._internal();

  static final DioHelper instance = DioHelper._internal();

  late final Dio dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      headers: {'Accept': 'application/vnd.github+json'},
    ),
  );
}
