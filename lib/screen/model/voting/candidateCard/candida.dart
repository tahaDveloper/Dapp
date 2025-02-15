// candidate.dart
class Candidate {
  final String name;
  int votes;

  Candidate({required this.name, this.votes = 0});

  void addVote() {
    votes++;
  }
}
