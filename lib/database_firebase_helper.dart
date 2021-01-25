library database_firebase_helper;
import 'package:reflectable/reflectable.dart';

// Annotate with this class to enable reflection.
class FirebaseReflector extends Reflectable {
  const FirebaseReflector()
      : super(invokingCapability,typingCapability, reflectedTypeCapability, metadataCapability); // Request the capability to invoke methods.
}

const firebaseReflector = const FirebaseReflector();

class MapTo {
  final String name;

  const MapTo(this.name);
}

const Id = const _Id();

class _Id {
  const _Id();
}

class DatabaseFirebaseHelper {
  static T getValue<T>(var snapshot) {

    var typeMirror = firebaseReflector.reflectType(T);
    var newInstance = (typeMirror as ClassMirror).newInstance("", []);

    InstanceMirror result = firebaseReflector.reflect(newInstance);
    var classMirror = (typeMirror as ClassMirror); //im.type;

    for (var ve in classMirror.declarations.entries) {
      var v = ve.value;
      var key = ve.key;

      if (!v.metadata.isEmpty) {
        if (v.metadata.first is _Id) {
          result.invokeSetter(key, snapshot.id);
        }
        else if (v.metadata.first is MapTo) {
          var name = (v.metadata.first as MapTo).name;
          result.invokeSetter(key, snapshot.data[name]);
        }
      }
    }

    return result.reflectee as T;
  }

  static Map toJson(value) {
    var result = {};

    var im = firebaseReflector.reflect(value);
    var classMirror = im.type;

    for (var ve in classMirror.declarations.entries) {
      var v = ve.value;
      var key = ve.key;

      if (!v.metadata.isEmpty) {
        if (v.metadata.first is MapTo) {
          var name = (v.metadata.first as MapTo).name;
          result[name] = im.invokeGetter(key);
        }
      }
    }
    return result;
  }
}
