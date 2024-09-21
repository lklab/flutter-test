// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyC8aSzOengywuEWv4Ow4zzCAcr8eGdAqek',
    appId: '1:400891870905:web:280423e4b7363243436568',
    messagingSenderId: '400891870905',
    projectId: 'flutter-chat-test-8e176',
    authDomain: 'flutter-chat-test-8e176.firebaseapp.com',
    storageBucket: 'flutter-chat-test-8e176.appspot.com',
    measurementId: 'G-37DEZT2QH5',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC8T2QPKTdl2ma5Kfm2KfztnpaSrM5gY7w',
    appId: '1:400891870905:android:87b7f193a9cc1429436568',
    messagingSenderId: '400891870905',
    projectId: 'flutter-chat-test-8e176',
    storageBucket: 'flutter-chat-test-8e176.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCSC_4qwwAWK2JGrLesU9cWQzaXMjyHmdc',
    appId: '1:400891870905:ios:f7270ff616267a27436568',
    messagingSenderId: '400891870905',
    projectId: 'flutter-chat-test-8e176',
    storageBucket: 'flutter-chat-test-8e176.appspot.com',
    iosBundleId: 'com.example.chattingApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCSC_4qwwAWK2JGrLesU9cWQzaXMjyHmdc',
    appId: '1:400891870905:ios:f7270ff616267a27436568',
    messagingSenderId: '400891870905',
    projectId: 'flutter-chat-test-8e176',
    storageBucket: 'flutter-chat-test-8e176.appspot.com',
    iosBundleId: 'com.example.chattingApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC8aSzOengywuEWv4Ow4zzCAcr8eGdAqek',
    appId: '1:400891870905:web:a13f3a607b888585436568',
    messagingSenderId: '400891870905',
    projectId: 'flutter-chat-test-8e176',
    authDomain: 'flutter-chat-test-8e176.firebaseapp.com',
    storageBucket: 'flutter-chat-test-8e176.appspot.com',
    measurementId: 'G-CMET710X2Z',
  );
}
