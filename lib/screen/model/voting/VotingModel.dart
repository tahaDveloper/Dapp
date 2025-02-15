import 'package:dio/dio.dart';
import 'package:get/get.dart';

class VotingService extends GetxService {
  final Dio _dio = Dio();

  Future<void> voteForCandidate(String proposalId) async {
    // Send request to vote for a candidate
    await _dio.post("YOUR_API_URL/vote", data: {'proposalId': proposalId});
  }

  Future<Map<String, dynamic>> getVotingResults() async {
    // Get voting results
    final response = await _dio.get("YOUR_API_URL/results");
    return response.data;
  }
}
