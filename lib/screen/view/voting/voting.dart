import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widget/customeNavigation/widget_navigation.dart';

class Voting_Page extends StatefulWidget {
  @override
  _VotingScreenState createState() => _VotingScreenState();
}

class _VotingScreenState extends State<Voting_Page> {
  List<Player> players = [
    Player(
      name: 'NebulaHunter',
      imageUrl: 'https://example.com/nebulahunter.jpg',
      votes: 0,
    ),
    Player(
      name: 'IronShadow',
      imageUrl: 'https://example.com/ironshadow.jpg',
      votes: 0,
    ),
  ];

  bool hasVoted = false;

  double get totalVotes => players.fold(0, (sum, player) => sum + player.votes);

  double getPlayerPercentage(int playerVotes) {
    if (totalVotes == 0) return 0;
    return (playerVotes / totalVotes) * 100;
  }

  void voteForPlayer(int index) {
    if (!hasVoted) {
      setState(() {
        players[index].votes++;
        hasVoted = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Voting", style: TextStyle(fontFamily: 'Fantasy', color: Color(0xffE2E2B6))),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // کارت رای‌گیری
            for (int i = 0; i < players.length; i++) ...[
              _buildVoteCard(
                imageUrl: players[i].imageUrl,
                name: players[i].name,
                votes: players[i].votes,
                onVote: () => voteForPlayer(i),
              ),
              SizedBox(height: 20),
            ],
            _buildImpressionsChart(),
          ],
        ),
      ),
      bottomNavigationBar: Navigation(),
    );
  }

  Widget _buildVoteCard({
    required String imageUrl,
    required String name,
    required int votes,
    required VoidCallback onVote,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Color(0xff6EACDA), Color(0xff03346E)]),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Color(0xff03346E).withOpacity(0.6), blurRadius: 15)],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
            radius: 30,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(color: Color(0xffE2E2B6), fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Vote for this legendary player!',
                  style: TextStyle(color: Color(0xff03346E),fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Color(0xff6EACDA),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Votes\n$votes',
                  style: TextStyle(color: Color(0xff03346E), fontSize: 13,fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: hasVoted ? null : onVote,
                style: ElevatedButton.styleFrom(
                  backgroundColor: hasVoted ? Colors.grey : Color(0xffE2E2B6),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text(
                  hasVoted ? 'Voted' : 'Vote Now',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: hasVoted ? Colors.black26 : Color(0xff03346E),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImpressionsChart() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Color(0xffE2E2B6).withOpacity(0.9),
            offset: Offset(6, 4),
            blurRadius: 12,
          ),
          BoxShadow(
            color:
          Color(0xff6EACDA).withOpacity(0.6),
            offset: Offset(-6, -6),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Player Impressions',
            style: TextStyle(color: Color(0xffE2E2B6), fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          for (int i = 0; i < players.length; i++) ...[
            _buildProgressBar(players[i].name, getPlayerPercentage(players[i].votes)),
            SizedBox(height: 10),
          ],
        ],
      ),
    );
  }

  Widget _buildProgressBar(String label, double percentage) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.white70, fontSize: 16),
        ),
        SizedBox(height: 6),
        LinearProgressIndicator(
          value: percentage / 100,
          backgroundColor: Colors.white24,
          color: Color(0xff6EACDA),
          minHeight: 10,
        ),
        SizedBox(height: 4),
        Text(
          '${percentage.toStringAsFixed(1)}%',
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
      ],
    );
  }
}

class Player {
  final String name;
  final String imageUrl;
  int votes;

  Player({
    required this.name,
    required this.imageUrl,
    required this.votes,
  });
}
