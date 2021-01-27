library database_firebase_helper;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_platform_interface/cloud_firestore_platform_interface.dart'
    as i;
import 'package:reflectable/reflectable.dart';

part 'src/annotations.dart';

part 'src/reflector.dart';

extension DocumentSnapshotExtention on DocumentSnapshot {
  /// Retrieve the data of the document into a (reflectable) object.
  T getValue<T>() {
    return _getValue(this);
  }
}

extension DocumentReferenceExtention on DocumentReference {
  /// Updates data on the document using an object. Data will be merged with
  /// any existing document data.
  ///
  /// If no document exists yet, the update will fail.
  Future<void> update(object) {
    return this.update(DatabaseFirebaseHelper.toJson(object));
  }

  /// Sets data on the document an object, overwriting any existing data. If the
  /// document does not yet exist, it will be created.
  ///
  /// If [SetOptions] are provided, the data will be merged into an existing
  /// document instead of overwriting.
  Future<void> set(object, [i.SetOptions options]) {
    return this.set(DatabaseFirebaseHelper.toJson(object), options);
  }
}

extension CollectionReferenceExtention on CollectionReference {
  /// Returns a `DocumentReference` with an auto-generated ID, after
  /// populating it with provided [object].
  ///
  /// The unique key generated is prefixed with a client-generated timestamp
  /// so that the resulting list will be chronologically-sorted.
  Future<DocumentReference> add(object) {
    return this.add(DatabaseFirebaseHelper.toJson(object));
  }
}

T _getValue<T>(DocumentSnapshot documentSnapshot) {
  var typeMirror = firebaseReflector.reflectType(T);
  var newInstance = (typeMirror as ClassMirror).newInstance("", []);

  InstanceMirror result = firebaseReflector.reflect(newInstance);
  var classMirror = (typeMirror as ClassMirror); //im.type;

  for (var ve in classMirror.declarations.entries) {
    var v = ve.value;
    var key = ve.key;

    for (var metadata in v.metadata) {
      if (metadata is _Id) {
        result.invokeSetter(key, documentSnapshot.id);
      } else if (metadata is MapTo) {
        var name = metadata.name;
        result.invokeSetter(key, documentSnapshot.get(name));
      }
    }
  }

  return result.reflectee as T;
}

class DatabaseFirebaseHelper {
  /// Convert any (reflectable) object into Map
  static Map toJson(value) {
    var result = {};

    var im = firebaseReflector.reflect(value);
    var classMirror = im.type;

    for (var ve in classMirror.declarations.entries) {
      var v = ve.value;
      var key = ve.key;

      for (var metadata in v.metadata) {
        if (metadata is MapTo) {
          var name = metadata.name;
          result[name] = im.invokeGetter(key);
        }
      }
    }
    return result;
  }
}
