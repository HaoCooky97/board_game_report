import 'package:board_game_report/boss.dart';
import 'package:board_game_report/exist_exception.dart';
import 'package:board_game_report/user.dart';

class Board {
  final Map<String, User> users;
  final Boss boss;

  Board.init(String name)
      : users = {},
        boss = Boss(name);

  void addUser(User user) {
    bool exist = users.containsKey(user.name) || boss.name == user.name;
    if (exist) {
      throw ExistException();
    } else {
      users[user.name] = user;
    }
  }

  void removeUser(String name) {
    users.remove(name);
  }

  bool existUser(String name) {
    return users.containsKey(name);
  }
}
