
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyDEbwf2Ckwd8FlzdaigJq3WeRAwd8Bdprg',
    appId: '1:801457142609:web:95bb088db8e2e475093170',
    messagingSenderId: '801457142609',
    projectId: 'key-rack',
    authDomain: 'key-rack.firebaseapp.com',
    databaseURL: 'https://key-rack-default-rtdb.firebaseio.com',
    storageBucket: 'key-rack.appspot.com',
    measurementId: 'G-GWM4FBDYPR',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB0sxh-mGIMQC4xBUS8T43Et8X4C79jZMc',
    appId: '1:801457142609:android:d1a68c3b3fff6e38093170',
    messagingSenderId: '801457142609',
    projectId: 'key-rack',
    databaseURL: 'https://key-rack-default-rtdb.firebaseio.com',
    storageBucket: 'key-rack.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBLu6yPNdcKFYVnViZzNzrIsv1p8UhvkkI',
    appId: '1:801457142609:ios:1c3dfe9b306f6bf2093170',
    messagingSenderId: '801457142609',
    projectId: 'key-rack',
    databaseURL: 'https://key-rack-default-rtdb.firebaseio.com',
    storageBucket: 'key-rack.appspot.com',
    iosBundleId: 'com.example.keyrack',
  );
}
