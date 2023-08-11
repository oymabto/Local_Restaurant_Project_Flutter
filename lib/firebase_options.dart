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
    apiKey: 'AIzaSyBILGLh5kGPNWR3HiUBWG9m4H3UbmI-IDg',
    appId: '1:435487917787:web:fb473430e7bc3f6455aefe',
    messagingSenderId: '435487917787',
    projectId: 'rtfinalproject',
    authDomain: 'rtfinalproject.firebaseapp.com',
    databaseURL: 'https://rtfinalproject-default-rtdb.firebaseio.com',
    storageBucket: 'rtfinalproject.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB5_-8CBMFvw-7Ewjkw9EJDzYnstxusGrY',
    appId: '1:435487917787:android:d6ae6195224098c355aefe',
    messagingSenderId: '435487917787',
    projectId: 'rtfinalproject',
    databaseURL: 'https://rtfinalproject-default-rtdb.firebaseio.com',
    storageBucket: 'rtfinalproject.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDldX2FD_ORHuImFMtWNLFpDWD431nf3-w',
    appId: '1:435487917787:ios:03858effd31cce1055aefe',
    messagingSenderId: '435487917787',
    projectId: 'rtfinalproject',
    databaseURL: 'https://rtfinalproject-default-rtdb.firebaseio.com',
    storageBucket: 'rtfinalproject.appspot.com',
    iosClientId: '435487917787-1b9dgv9ph1hns53m373i92enek0hufqj.apps.googleusercontent.com',
    iosBundleId: 'ca.bobers.rtFinalProject',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDldX2FD_ORHuImFMtWNLFpDWD431nf3-w',
    appId: '1:435487917787:ios:3847d6f0b565955055aefe',
    messagingSenderId: '435487917787',
    projectId: 'rtfinalproject',
    databaseURL: 'https://rtfinalproject-default-rtdb.firebaseio.com',
    storageBucket: 'rtfinalproject.appspot.com',
    iosClientId: '435487917787-go6v8gqfn8k99mjhgtk9tecpj5egl6c5.apps.googleusercontent.com',
    iosBundleId: 'ca.bobers.rtFinalProject.RunnerTests',
  );
}