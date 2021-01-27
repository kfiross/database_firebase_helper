part of database_firebase_helper;

/// Annotate with this class will enable reflection.
class FirebaseReflector extends Reflectable {
  const FirebaseReflector()
      : super(invokingCapability, typingCapability, reflectedTypeCapability,
            metadataCapability); // Request the capability to invoke methods.
}

/// shorthand usage
const firebaseReflector = const FirebaseReflector();
