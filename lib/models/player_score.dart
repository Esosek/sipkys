class PlayerScore {
  const PlayerScore({
    required this.totalScore,
    this.throwScores = const [],
    this.curRoundScores = const [],
  });

  final int totalScore;
  final List<int> curRoundScores;
  final List<int> throwScores;

  PlayerScore copyWith({
    int? totalScore,
    List<int>? curRoundScores,
    List<int>? throwScores,
  }) {
    return PlayerScore(
      totalScore: totalScore ?? this.totalScore,
      curRoundScores: curRoundScores ?? this.curRoundScores,
      throwScores: throwScores ?? this.throwScores,
    );
  }

  int get totalRoundScore {
    int value = 0;
    for (var score in curRoundScores) {
      value += score;
    }
    return value;
  }
}
