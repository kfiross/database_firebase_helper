part of database_firebase_helper;

/// Annotate with this class will enable reflection.
class _FirebaseReflector extends Reflectable {
  const _FirebaseReflector()
      : super(invokingCapability,typingCapability, reflectedTypeCapability, metadataCapability); // Request the capability to invoke methods.
}

/// shorthand usage
const firebaseReflector = const _FirebaseReflector();