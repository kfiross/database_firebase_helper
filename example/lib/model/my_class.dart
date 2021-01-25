import 'package:database_firebase_helper/database_firebase_helper.dart';

@firebaseReflector
class MyClass{
  @Id
  String mId;

  @MapTo('name')
  String mName;

  @MapTo('age')
  int mAge;
}