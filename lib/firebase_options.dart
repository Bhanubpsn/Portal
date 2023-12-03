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
    apiKey: 'AIzaSyDvHdzKSxIRgfcFbr-B2mvqo5eh6mosd7g',
    appId: '1:113396010755:web:99435927c2838b3a572336',
    messagingSenderId: '113396010755',
    projectId: 'thaiseva-85cda',
    authDomain: 'thaiseva-85cda.firebaseapp.com',
    storageBucket: 'thaiseva-85cda.appspot.com',
    measurementId: 'G-9SX3H7Y0CK',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCMBbIQqie59lAZYwyasjKYr0iF7Z4oqdo',
    appId: '1:113396010755:android:951b6b7b46f2a561572336',
    messagingSenderId: '113396010755',
    projectId: 'thaiseva-85cda',
    storageBucket: 'thaiseva-85cda.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyApAUpaA7U8O2m5GqwFCJoTyD4Qou0nLj8',
    appId: '1:113396010755:ios:0a2ec8dfd429f106572336',
    messagingSenderId: '113396010755',
    projectId: 'thaiseva-85cda',
    storageBucket: 'thaiseva-85cda.appspot.com',
    androidClientId: '113396010755-m40vjq2j34bcepsv1d2n62gsoe5hpb4t.apps.googleusercontent.com',
    iosBundleId: 'com.example.cehpoint',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyApAUpaA7U8O2m5GqwFCJoTyD4Qou0nLj8',
    appId: '1:113396010755:ios:cfb49e02d3a4b28d572336',
    messagingSenderId: '113396010755',
    projectId: 'thaiseva-85cda',
    storageBucket: 'thaiseva-85cda.appspot.com',
    androidClientId: '113396010755-m40vjq2j34bcepsv1d2n62gsoe5hpb4t.apps.googleusercontent.com',
    iosBundleId: 'com.example.cehpoint.RunnerTests',
  );
}
