import 'package:board_game_report/board.dart';
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

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Board board;
  User? _userSelected;

  @override
  void initState() {
    super.initState();
    board = Board.init(widget.title);
  }

  @override
  Widget build(BuildContext context) {
    final List<User> users = this.board.users.values.toList();
    final bool userHover = _userSelected != null;
    final buttonAddUser = FloatingActionButton(
      onPressed: handleAddUser,
      child: Icon(Icons.add),
    );
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [buttonAddUser],
        ),
        body: Flex(
          direction: Axis.vertical,
          children: [
            Flexible(
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (_, index) {
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
                      crossAxisAlignment: CrossAxisAlignment.end,
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
        ));
  }

  void handleAddUser() {
    try {
      setState(() {
        this.board.addUser(User("${DateTime.now()}"));
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
