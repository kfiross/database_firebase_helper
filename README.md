# database_firebase_helper

A Flutter (pure-dart) package to simpler FromMap/ToJson when working with Firebase Firestore

Inspired by the implementation on Java :)<br>
Heavily based on the great package  [reflectable](https://pub.dev/packages/reflectable) 
## Getting Started

### Setup
Make sure in `main.dart`:

1. Add `reflectable` generated file import:

```dart
import 'main.reflectable.dart';
```

2. On the `main()` function add:
```dart
initializeReflectable();  
```
In order to set up reflection support.

### Annotate your class
```dart
@firebaseReflector      // ---> This annotation enables reflection on your class
class MyClass{
  @Id             // ---> This annotation marks member as Document's id
  String mId;

  @MapTo('name')  // ---> This annotation marks member as the field in the Document
  String mName;

  @MapTo('age')
  int mAge;
}
```

### Build

Use `build_runner` to generate the ` 'main.reflectable.dart'` file:
```
$ flutter pub run build_runner build
```
* You have to run it each time you modify your classes


## Usage

### On a document snapshot
* Get your object directly from the snapshot, for example:
```dart
DocSnapshot snapshot = FirebaseFirestore.getInstance.doc(<doc_path>)
var myClass = snaphot.getValue<MyClass>(snapshot);
```


* You can also use `set` and `update` function from your object, for example:
```dart
DocSnapshot snapshot = FirebaseFirestore.getInstance.doc("myCollection/myDoc")
// set
snaphot.set(<My Class Instance>);

// update
snaphot.update(<My Class Instance>);
```

* You can also can convert Object into Map, for example:
```dart
Map jsonMap = DatabaseFirebaseHelper.toJson(<My Class Instance>);
```

### On a collection snapshot
* You can use `add` function using from an object, for example:
```dart
var snapshot = FirebaseFirestore.getInstance.collection("myCollection");
snapshot.add(<My Class Instance>);
```