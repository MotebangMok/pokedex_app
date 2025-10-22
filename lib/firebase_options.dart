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
    apiKey: 'AIzaSyCB0jgWL_FU2XBakVJ6ZTd_rq-U0qVco-0',
    appId: '1:239862593499:web:f2e0f5f06a974433be99fe',
    messagingSenderId: '239862593499',
    projectId: 'pokedex-test-app',
    authDomain: 'pokedex-test-app.firebaseapp.com',
    storageBucket: 'pokedex-test-app.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDJyQ94hXlATjOYvYVfviNJzgNkSOdruL0',
    appId: '1:239862593499:android:3c7957891db17774be99fe',
    messagingSenderId: '239862593499',
    projectId: 'pokedex-test-app',
    storageBucket: 'pokedex-test-app.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB6RUgmSIqyKIMPJo2yeiqSRqa_aKaBM40',
    appId: '1:239862593499:ios:30af277bc857aa6bbe99fe',
    messagingSenderId: '239862593499',
    projectId: 'pokedex-test-app',
    storageBucket: 'pokedex-test-app.firebasestorage.app',
    iosBundleId: 'com.example.pokedexTestApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDummy-Key-For-Development',
    appId: '1:1234567890:ios:abcdef1234567890',
    messagingSenderId: '1234567890',
    projectId: 'pokedex-app-demo',
    storageBucket: 'pokedex-app-demo.appspot.com',
    iosBundleId: 'com.example.pokedexTestApp',
  );
}