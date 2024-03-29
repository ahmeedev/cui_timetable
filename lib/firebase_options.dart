import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
// Package imports:

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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyD8gnpj5mQFYwoUyjgG8FrrJK8Sxk8yR7k',
    appId: '1:663627456598:web:b6b26d8217f50bb4ea9bf7',
    messagingSenderId: '663627456598',
    projectId: 'cui-timetable',
    authDomain: 'cui-timetable.firebaseapp.com',
    databaseURL: 'https://cui-timetable-default-rtdb.firebaseio.com',
    storageBucket: 'cui-timetable.appspot.com',
    measurementId: 'G-K9J869PKKC',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDSMQKX7E4tmETXoKH72urG3tW8bYuDB1U',
    appId: '1:663627456598:android:3fe44ae09df5ad42ea9bf7',
    messagingSenderId: '663627456598',
    projectId: 'cui-timetable',
    databaseURL: 'https://cui-timetable-default-rtdb.firebaseio.com',
    storageBucket: 'cui-timetable.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBrHwBUbYTga1qC5MbeT9W5GDuHRF5jpbA',
    appId: '1:663627456598:ios:70b30863ae7f8111ea9bf7',
    messagingSenderId: '663627456598',
    projectId: 'cui-timetable',
    databaseURL: 'https://cui-timetable-default-rtdb.firebaseio.com',
    storageBucket: 'cui-timetable.appspot.com',
    iosClientId:
        '663627456598-ed6tiqk5sn2v9ohraei9dp8iiq18eovk.apps.googleusercontent.com',
    iosBundleId: 'com.rise4solution.cuiTimetable',
  );
}
