import 'package:board_game_report/constants/constants.dart';
import 'package:board_game_report/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserItem extends StatelessWidget {
  final User user;
  final VoidCallback? onUserPress;
  final VoidCallback? onDeletePress;
  final bool _isSelected;

  const UserItem(this.user, {Key? key, this.onUserPress, this.onDeletePress})
      : _isSelected = false,
        super(key: key);

  const UserItem.selected(this.user,
      {Key? key, this.onUserPress, this.onDeletePress})
      : _isSelected = true,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final Status status = user.getStatus();
    final Widget leading = Icon(getIcon(status), color: getColor(status));
    return Slidable(
      actionExtentRatio: 0.12,
      child: ListTile(
        selected: _isSelected,
        leading: leading,
        title: Text(user.name),
        onTap: onUserPress,
      ),
      actionPane: SlidableDrawerActionPane(),
      secondaryActions: [
        IconButton(
          onPressed: onDeletePress,
          iconSize: 32,
          icon: SvgPicture.asset(Assets.COIN),
        ),
        VerticalDivider(),
        IconButton(
          onPressed: onDeletePress,
          iconSize: 32,
          icon: Icon(
            Icons.remove_circle,
            color: Colors.red,
          ),
        ),
      ],
    );
  }

  Color getColor(Status status) {
    switch (status) {
      case Status.win:
        return Colors.green;
      case Status.lose:
        return Colors.red;
      case Status.equal:
        return Colors.yellow;
    }
  }

  IconData getIcon(Status status) {
    switch (status) {
      case Status.win:
        return Icons.arrow_upward;
      case Status.lose:
        return Icons.arrow_downward;
      case Status.equal:
        return Icons.menu;
    }
  }
}
