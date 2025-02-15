// lib/api/api_client.dart
import 'package:dio/dio.dart';

import 'netWork.dart';

class ApiClient {
  late RestClient nftApiService;

  ApiClient() {
    final dio = Dio();
    dio.options.headers["Content-Type"] = "application/json";
    nftApiService = RestClient(dio);
  }
}
