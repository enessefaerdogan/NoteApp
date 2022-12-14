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
    apiKey: 'AIzaSyDnFrXV1sEIS4J7zzR5y8ZZbm8ZVT_hUf4',
    appId: '1:590164116515:web:7b342a3234d2b131c5dd96',
    messagingSenderId: '590164116515',
    projectId: 'noteapp-enessefa',
    authDomain: 'noteapp-enessefa.firebaseapp.com',
    storageBucket: 'noteapp-enessefa.appspot.com',
    measurementId: 'G-Z83T49HNWY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCAQwfbxft04j4yiK9RlkH4xl0GQSqTDLs',
    appId: '1:590164116515:android:0f6f1408649fec02c5dd96',
    messagingSenderId: '590164116515',
    projectId: 'noteapp-enessefa',
    storageBucket: 'noteapp-enessefa.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDh1VTsFpQfP8GsMgAlh1_TegfhdUlkWKc',
    appId: '1:590164116515:ios:f66bc8322ba140aec5dd96',
    messagingSenderId: '590164116515',
    projectId: 'noteapp-enessefa',
    storageBucket: 'noteapp-enessefa.appspot.com',
    iosClientId: '590164116515-f0h02torvkn9d342v5bbkmbblf9uvome.apps.googleusercontent.com',
    iosBundleId: 'com.example.noteApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDh1VTsFpQfP8GsMgAlh1_TegfhdUlkWKc',
    appId: '1:590164116515:ios:f66bc8322ba140aec5dd96',
    messagingSenderId: '590164116515',
    projectId: 'noteapp-enessefa',
    storageBucket: 'noteapp-enessefa.appspot.com',
    iosClientId: '590164116515-f0h02torvkn9d342v5bbkmbblf9uvome.apps.googleusercontent.com',
    iosBundleId: 'com.example.noteApp',
  );
}
