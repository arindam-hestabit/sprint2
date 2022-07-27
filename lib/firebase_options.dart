// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCK71MdsRpCTauCicqfyXDCg9iHkUgcId0',
    appId: '1:177035407378:web:66f63f134a9bc7424b68cb',
    messagingSenderId: '177035407378',
    projectId: 'arindam-sprint',
    authDomain: 'arindam-sprint.firebaseapp.com',
    storageBucket: 'arindam-sprint.appspot.com',
    measurementId: 'G-HVTYD2B5DM',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC8cvfwOYsFRL0w0po-DNdEgpdjO4RpQec',
    appId: '1:177035407378:android:efd4aecf300fb03c4b68cb',
    messagingSenderId: '177035407378',
    projectId: 'arindam-sprint',
    storageBucket: 'arindam-sprint.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDmkJMx2cGLr6DlqyENifbeyUoE7JimaeU',
    appId: '1:177035407378:ios:691e688330651b9e4b68cb',
    messagingSenderId: '177035407378',
    projectId: 'arindam-sprint',
    storageBucket: 'arindam-sprint.appspot.com',
    iosClientId: '177035407378-ld3gceqddtds8fja052rv92ik2d3qhin.apps.googleusercontent.com',
    iosBundleId: 'com.example.sprint2',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDmkJMx2cGLr6DlqyENifbeyUoE7JimaeU',
    appId: '1:177035407378:ios:691e688330651b9e4b68cb',
    messagingSenderId: '177035407378',
    projectId: 'arindam-sprint',
    storageBucket: 'arindam-sprint.appspot.com',
    iosClientId: '177035407378-ld3gceqddtds8fja052rv92ik2d3qhin.apps.googleusercontent.com',
    iosBundleId: 'com.example.sprint2',
  );
}