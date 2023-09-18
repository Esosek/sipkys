class PlayerScore {
  PlayerScore(this._initialScore) : _totalScore = _initialScore;

  final int _initialScore;
  int _totalScore;
  final List<int> _roundScores = [];
  final List<int> _throwScores = [];
  final List<int> _currentRoundScores = [];
  int _darts = 3;

  int _currentRoundTotalScore = 0;

  int get totalScore => _totalScore;
  int get roundScore => _currentRoundTotalScore;
  List<int> get roundThrows => _roundScores;

  double get roundAvg {
    int scored = _initialScore - _totalScore;
    return scored / _roundScores.length; // score/rounds
  }

  void saveThrow(int value) {
    _totalScore -= value;
    _throwScores.add(value);
    _currentRoundTotalScore += value;
    _darts--;

    if (_darts == 0) {
      _roundScores.add(_currentRoundTotalScore);
    }
  }

  void startRound() {
    _currentRoundScores.clear();
    _currentRoundTotalScore = 0;
    _darts = 3;
  }
}
