import 'package:board_game_report/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class UserItem extends StatelessWidget {
  final User user;
  final VoidCallback? onUserPress;
  final VoidCallback? onDeletePress;

  const UserItem(this.user, {Key? key, this.onUserPress, this.onDeletePress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isWin = user.total() > 0;
    final Widget leading = isWin
        ? Icon(Icons.arrow_upward, color: Colors.green)
        : Icon(Icons.arrow_downward, color: Colors.red);
    return Slidable(
      child: ListTile(
        leading: leading,
        title: Text(user.name),
        onTap: onUserPress,
      ),
      actionPane: ElevatedButton.icon(
        onPressed: onDeletePress,
        icon: Icon(Icons.delete),
        label: Text("Delete"),
      ),
    );
  }
}
