# database_firebase_helper

A Flutter (pure-dart) package to simpler FromMap/ToJson when working with Firebase Firestore

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
> flutter pub run build_runner build
```
* run it each time you modify your classes


# Usage

* Get object from snapshot, for example:
```dart
var myClass = DatabaseFirebaseHelper.getValue<MyClass>(snapshot);
```


* Convert Object into Map, for example:
```dart
Map jsonMap = DatabaseFirebaseHelper.toJson(<MyClass Instance>);
```
