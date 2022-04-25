class OnlineBattle {
  String playerOneId;
  String playerOneUsername;
  String playerTwoId;
  String playerTwoUsername;
  List<Map<String, dynamic>> cards;

  OnlineBattle({
    required this.playerOneId,
    required this.playerOneUsername,
    required this.playerTwoId,
    required this.playerTwoUsername,
    required this.cards,
  });

  factory OnlineBattle.fromJson(
      Map<String, dynamic> json, List<Map<String, dynamic>> cards) {
    return OnlineBattle(
      playerOneId: json['player_one_id'],
      playerOneUsername: json['player_one_username'],
      playerTwoId: json['player_one_id'],
      playerTwoUsername: json['player_two_username'],
      cards: cards,
    );
  }
}
