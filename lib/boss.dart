class Boss {
  final String name;
  int _winChip;
  int _loseChip;

  Boss(this.name, {winChip = 0, loseChip = 0})
      : _loseChip = loseChip,
        _winChip = winChip;

  int win(int chips) {
    _winChip += chips;
    return _winChip;
  }

  int lose(int chips) {
    _loseChip += chips;
    return _loseChip;
  }

  int total() => _loseChip - _winChip;

  MapEntry<int, int> get report => MapEntry(_winChip, _loseChip);
}
