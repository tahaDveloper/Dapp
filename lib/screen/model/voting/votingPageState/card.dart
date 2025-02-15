import 'package:flutter/cupertino.dart';

class CandidateCard extends StatelessWidget {
  final String name;
  final int votes;
  final VoidCallback onVote;

  CandidateCard({
    required this.name,
    required this.votes,
    required this.onVote,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}