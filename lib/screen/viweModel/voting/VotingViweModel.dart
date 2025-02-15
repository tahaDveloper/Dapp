import 'package:get/get.dart';

import '../../model/voting/VotingModel.dart';

class VotingController extends GetxController {
  final VotingService votingService = VotingService();
  var hasVoted = false.obs; // وضعیت رأی‌گیری
  var votingResults = <String, BigInt>{ 'candidate1': BigInt.zero, 'candidate2': BigInt.zero }.obs;

  Future<void> voteForCandidate(String proposalId) async {
    if (hasVoted.value) {
      Get.snackbar('خطا', 'شما قبلاً رأی داده‌اید!');
      return;
    }
    await votingService.voteForCandidate(proposalId);
    hasVoted.value = true;
    Get.snackbar('موفقیت', 'شما برای کاندیدا رأی داده‌اید!');
  }

  Future<void> fetchResults() async {
    final results = await votingService.getVotingResults();
    votingResults['candidate1'] = results['candidate1'];
    votingResults['candidate2'] = results['candidate2'];
  }
}
