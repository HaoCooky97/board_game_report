import 'package:board_game_report/board.dart';
import 'package:board_game_report/common/ui/atoms/atoms.dart';
import 'package:board_game_report/exist_exception.dart';
import 'package:board_game_report/user.dart';
import 'package:board_game_report/user_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Board board;
  User? _userSelected;
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    board = Board.init(widget.title);
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final List<User> users = this.board.users.values.toList();
    final bool userHover = _userSelected != null;
    final buttonAddUser = FloatingActionButton(
      onPressed: canAddUser() ? handleAddUser : null,
      child: Icon(Icons.add),
    );
    return Scaffold(
        body: Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      child: Flex(
        direction: Axis.vertical,
        children: [
          Container(
            height: 64,
            margin: EdgeInsets.all(16),
            child: Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: BorderEditText(
                    controller: controller,
                    onChanged: (_) {
                      setState(() {});
                    },
                  ),
                  flex: 4,
                ),
                Flexible(child: buttonAddUser),
              ],
            ),
          ),
          Flexible(
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (_, index) {
                if (_userSelected?.name == users[index].name) {
                  return UserItem.selected(
                    users[index],
                    onUserPress: () => handleUserPress(users[index]),
                    onDeletePress: () => handleDeleteUser(users[index]),
                  );
                }
                return UserItem(
                  users[index],
                  onUserPress: () => handleUserPress(users[index]),
                );
              },
            ),
          ),
          userHover
              ? Container(
                  height: 64,
                  child: Flex(
                    direction: Axis.horizontal,
                    children: [
                      Flexible(
                        child: Center(
                          child: Text(
                            _userSelected!.total().toString(),
                            style: Theme.of(context).textTheme.headline3,
                          ),
                        ),
                        flex: 1,
                      ),
                      Flexible(
                        child: Flex(
                          direction: Axis.horizontal,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // FloatingActionButton(
                            //   onPressed: () {},
                            //   child: Text("Huề"),
                            //   backgroundColor: Colors.blue,
                            // ),
                            FloatingActionButton(
                              onPressed: handleLoose,
                              child: Text("Thua"),
                              backgroundColor: Colors.red,
                            ),
                            FloatingActionButton(
                              onPressed: handleWin,
                              child: Text("Thắng"),
                              backgroundColor: Colors.green,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : SizedBox()
        ],
      ),
    ));
  }

  void handleAddUser() {
    try {
      setState(() {
        String name = controller.text;
        if (name.trim().isNotEmpty || this.board.existUser(name)) {
          this.board.addUser(User(name));
        }
      });
    } catch (ex) {
      if (ex is ExistException) {
        print('hello');
      }
    }
  }

  void handleUserPress(User user) {
    try {
      setState(() {
        bool isHover = _userSelected?.name == user.name;
        if (isHover) {
          _userSelected = null;
        } else {
          _userSelected = user;
        }
      });
    } catch (ex) {
      print(ex);
    }
  }

  void handleDeleteUser(User user) {
    try {
      setState(() {
        this.board.removeUser(user.name);
        if (_userSelected?.name == user.name) {
          _userSelected = null;
        }
      });
    } catch (ex) {
      print(ex);
    }
  }

  bool canAddUser() =>
      controller.text.trim().isNotEmpty ||
      this.board.existUser(controller.text);

  void handleWin() {
    try {
      setState(() {
        _userSelected!.win();
      });
    } catch (ex) {
      print(ex);
    }
  }

  void handleLoose() {
    try {
      setState(() {
        _userSelected!.lose();
      });
    } catch (ex) {
      print(ex);
    }
  }

  void handleEqual() {
    try {
      setState(() {});
    } catch (ex) {
      print(ex);
    }
  }
}
