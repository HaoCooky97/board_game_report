enum Status { win, lose, equal }

class User {
  final String name;
  int chip;
  int _winChip;
  int _loseChip;

  User(this.name, {this.chip = 1, winChip = 0, loseChip = 0})
      : _loseChip = loseChip,
        _winChip = winChip;

  int win() {
    _winChip += chip;
    return _winChip;
  }

  int lose() {
    _loseChip += chip;
    return _loseChip;
  }

  int bet(int chip) {
    this.chip = chip;
    return this.chip;
  }

  Status getStatus() {
    final chip = total();
    if (chip == 0) {
      return Status.equal;
    }
    return chip > 0 ? Status.win : Status.lose;
  }

  int total() => _winChip - _loseChip;

  MapEntry<int, int> get report => MapEntry(_winChip, _loseChip);
}
