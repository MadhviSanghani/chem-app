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
    apiKey: 'AIzaSyBh47lt3Prfthu4kTqpXR3w8PmYCsb4hKQ',
    appId: '1:834281610808:web:404520e53cc83de41210cd',
    messagingSenderId: '834281610808',
    projectId: 'finalproject-e69b2',
    authDomain: 'finalproject-e69b2.firebaseapp.com',
    storageBucket: 'finalproject-e69b2.firebasestorage.app',
    measurementId: 'G-48VSQBJQQW',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyApa5XZRMipub7mH8I3WqAhVCczZybsRus',
    appId: '1:834281610808:android:2603644a0e08198c1210cd',
    messagingSenderId: '834281610808',
    projectId: 'finalproject-e69b2',
    storageBucket: 'finalproject-e69b2.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyArqNjRM3QhwxXoz1s_63RKGq2lsObPwjk',
    appId: '1:834281610808:ios:cb2dc40492f78bcd1210cd',
    messagingSenderId: '834281610808',
    projectId: 'finalproject-e69b2',
    storageBucket: 'finalproject-e69b2.firebasestorage.app',
    iosBundleId: 'com.example.adminLogin',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyArqNjRM3QhwxXoz1s_63RKGq2lsObPwjk',
    appId: '1:834281610808:ios:cb2dc40492f78bcd1210cd',
    messagingSenderId: '834281610808',
    projectId: 'finalproject-e69b2',
    storageBucket: 'finalproject-e69b2.firebasestorage.app',
    iosBundleId: 'com.example.adminLogin',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBh47lt3Prfthu4kTqpXR3w8PmYCsb4hKQ',
    appId: '1:834281610808:web:9249f7f3544f34421210cd',
    messagingSenderId: '834281610808',
    projectId: 'finalproject-e69b2',
    authDomain: 'finalproject-e69b2.firebaseapp.com',
    storageBucket: 'finalproject-e69b2.firebasestorage.app',
    measurementId: 'G-7GBGMLSHND',
  );

}