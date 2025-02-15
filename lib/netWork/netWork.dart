import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';

import 'nftModel.dart';



part  'netWork.g.dart';

//rest_client
@RestApi(baseUrl: 'https://jsonplaceholder.typicode.com/')//ادرس بیس وب سرویس


abstract class RestClient
{
  factory RestClient(Dio dio, {String? baseUrl}) = _RestClient;

  @GET("/posts")//name file
  Future<List<NFT>> fetchNFTs();

}