import 'package:database_firebase_helper/database_firebase_helper.dart';
import 'package:flutter/material.dart';
import 'main.reflectable.dart';
import 'model/my_class.dart';


/// Mimic Firestore's DocumentSnapshot Object
class Snapshot{
  final String id;
  final Map data;

  Snapshot({this.id, this.data});
}

void main() {
  initializeReflectable(); // Set up reflection support.
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Example',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    var snapshot = Snapshot(
        id: 'abcserf',
        data: {
          'name': 'Kfir',
          'age': 26
        }
    );

    var myClass = DatabaseFirebaseHelper.getValue<MyClass>(snapshot);

    MyClass c = MyClass();
    c.mId = "abcd";
    c.mAge = 24;
    c.mName = "Moshe";

    var map = DatabaseFirebaseHelper.toJson(c);
    print(map);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Example")),
      body: Center(
        child: Text("Home"),
      ),
    );
  }
}

